import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:secretbox/features/game/presentation/providers/game_state_provider.dart';
import 'package:secretbox/features/game/presentation/providers/state/game_state.dart';
import 'package:secretbox/shared/domain/models/prize.dart';
import 'package:secretbox/shared/utils/upper_case_formatter.dart';
import 'package:secretbox/shared/widgets/background_widget.dart';
import 'package:secretbox/features/game/presentation/widgets/box_widget.dart';
import 'package:secretbox/shared/widgets/button_widget.dart';
import 'package:secretbox/shared/widgets/container_widget.dart';
import 'package:secretbox/shared/widgets/loading_widget.dart';
import 'package:secretbox/shared/domain/models/box_state.dart';
import 'package:secretbox/shared/domain/models/gameplay_state.dart';
import 'package:secretbox/shared/theme/app_colors.dart';
import 'package:secretbox/shared/theme/app_strings.dart';
import 'package:secretbox/shared/theme/text_styles.dart';
import 'package:secretbox/shared/utils/common_utils.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
  late TextEditingController _voucherController;
  final _audioPlayer = AudioPlayer();
  bool _hasInteracted = false;
  bool _showOverlay = false;
  Prize? _currentPrize;
  late AnimationController _overlayAnimationController;
  late Animation<double> _overlayFadeAnimation;

  @override
  void initState() {
    super.initState();
    _overlayAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _overlayFadeAnimation = CurvedAnimation(
      parent: _overlayAnimationController,
      curve: Curves.easeInOut,
    );
    _voucherController = TextEditingController();
    _voucherController.addListener(() {
      ref.read(voucherCodeProvider.notifier).state = _voucherController.text;
    });
  }

  @override
  void dispose() {
    _voucherController.dispose();
    _audioPlayer.dispose();
    _overlayAnimationController.dispose();
    super.dispose();
  }

  void _pauseAudio() {
    _audioPlayer.pause();
  }

  void _resumeAudio() {
    _audioPlayer.play();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(gameStateNotifierProvider);
    final audioEnabled = ref.watch(audioProvider);

    return state.when(
      initial: () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(gameStateNotifierProvider.notifier).initializeGame();
        });
        return const LoadingWidget();
      },
      loading:
          (setting) => BackgroundWidget(
            imageUrl: setting?.asset.backgroundImageUrl,
            child: LoadingWidget(),
          ),
      failure:
          (error) =>
              Center(child: Text('${AppStrings.error} ${error.message}')),
      success: (
        revealed,
        boxStates,
        gameplayState,
        countdownText,
        setting,
        voucher,
        error,
      ) {
        if (gameplayState == GameplayState.waiting && error != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error),
                duration: Duration(seconds: 2),
                backgroundColor: AppColors.error,
              ),
            );
          });
        }

        void clearVoucherField() {
          _voucherController.clear();
          ref.read(voucherCodeProvider.notifier).state = '';
        }

        Widget brandView() {
          return Align(
            alignment: Alignment.center,
            child: CachedNetworkImage(
              imageUrl: setting.company.brandImageUrl,
              // fit: BoxFit.cover,
            ),
          );
        }

        Widget dialogView() {
          return LayoutBuilder(
            builder: (context, constraints) {
              final height = constraints.maxHeight;

              return SizedBox.expand(
                child: Container(
                  color: AppColors.black38,
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.4, child: brandView()),
                      Container(
                        alignment: Alignment.topCenter,
                        height: height * 0.6,
                        child: ContainerWidget(
                          child: Column(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    setting.wording.welcomeText,
                                    style: AppTextStyles.h1.copyWith(
                                      shadows: [
                                        Shadow(
                                          offset: Offset(2, 2),
                                          blurRadius: 3,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 36),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width *
                                        (CommonUtils.isMobile(context)
                                            ? 0.5
                                            : 0.25),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),

                                    child: TextField(
                                      controller: _voucherController,
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(6),
                                        UpperCaseTextFormatter(),
                                      ],
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: AppStrings.enterVoucher,
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                      onChanged:
                                          (value) =>
                                              ref
                                                  .read(
                                                    voucherCodeProvider
                                                        .notifier,
                                                  )
                                                  .state = value,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (gameplayState.canStart)
                                        ButtonWidget(
                                          text: AppStrings.start,
                                          color: Colors.orange,
                                          onPressed: () {
                                            final code = ref.read(
                                              voucherCodeProvider,
                                            );
                                            print('CODE:: ' + code);
                                            if (code.isEmpty) {
                                              return;
                                            }

                                            ref
                                                .read(
                                                  gameStateNotifierProvider
                                                      .notifier,
                                                )
                                                .getVoucher(code);
                                            clearVoucherField();
                                          },
                                        ),

                                      const SizedBox(width: 16),
                                      if (gameplayState.canShowPrize)
                                        ButtonWidget(
                                          text: AppStrings.showPrizes,
                                          color: Colors.red,
                                          onPressed: () {
                                            ref
                                                .read(
                                                  gameStateNotifierProvider
                                                      .notifier,
                                                )
                                                .showAllPrizes();
                                            clearVoucherField();
                                          },
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }

        Widget gamePlayView() {
          return Column(
            children: [
              ButtonWidget(
                text:
                    gameplayState == GameplayState.finished
                        ? AppStrings.playAgain
                        : AppStrings.enterVoucher,
                color: Colors.orange,
                onPressed: () {
                  ref
                      .read(gameStateNotifierProvider.notifier)
                      .showVoucherInput(
                        gameplayState == GameplayState.finished,
                      );
                },
              ),
              SizedBox(height: 20),
            ],
          );
        }

        Widget _prizeOverlay() {
          if (_currentPrize == null) return const SizedBox.shrink();

          return FadeTransition(
            opacity: _overlayFadeAnimation,
            child: Container(
              color: Colors.black.withOpacity(0.8),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: _currentPrize!.imageUrl,
                    width: MediaQuery.of(context).size.width * 0.6,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _currentPrize!.name,
                    style: AppTextStyles.h2.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        Widget audioButton() {
          return Positioned(
            top: 24,
            left: 24,
            child: IconButton(
              color: Colors.blue,
              icon: Icon(
                audioEnabled ? Icons.volume_up : Icons.volume_off,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                ref.read(audioProvider.notifier).state = !audioEnabled;

                if (audioEnabled) {
                  _pauseAudio(); // Define this
                } else {
                  _resumeAudio(); // Define this
                }
              },
            ),
          );
        }

        Widget gameView() {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 20),
                    countdownText.isEmpty
                        ? SizedBox(height: 44)
                        : ContainerWidget(
                          child: Text(countdownText, style: AppTextStyles.h3),
                        ),
                  ],
                ),
                const SizedBox(height: 20),
                if (gameplayState.canShowPlayView) gamePlayView(),
                Expanded(
                  child: GridView.builder(
                    itemCount: setting.prizes.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: CommonUtils.crossAxisCount(context),
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      final shouldReveal =
                          revealed[index] ||
                          gameplayState == GameplayState.showing;
                      return BoxWidget(
                        prize: setting.prizes[index],
                        asset: setting.asset,
                        canOpen:
                            gameplayState == GameplayState.choosing &&
                            !shouldReveal,
                        boxState:
                            shouldReveal ? BoxState.opened : boxStates[index],
                        onOpened: () async {
                          await ref
                              .read(gameStateNotifierProvider.notifier)
                              .revealPrize(index);

                          final updatedState = ref.read(
                            gameStateNotifierProvider,
                          );
                          final prize = updatedState.maybeWhen(
                            success: (
                              revealed,
                              boxStates,
                              gameplayState,
                              countdownText,
                              setting,
                              voucher,
                              error,
                            ) {
                              final winningPrizeId = voucher?.prizeId;
                              return setting.prizes.firstWhere(
                                (p) => p.id == winningPrizeId,
                                orElse: () => setting.prizes[index], // fallback
                              );
                            },
                            orElse: () => null,
                          );

                          if (prize == null || !mounted) return;

                          // Step 3: show overlay
                          setState(() {
                            _currentPrize = prize;
                            _showOverlay = true;
                          });

                          _overlayAnimationController.forward();

                          await Future.delayed(const Duration(seconds: 3));
                          _overlayAnimationController.reverse();

                          await Future.delayed(
                            const Duration(milliseconds: 500),
                          );
                          if (mounted) {
                            setState(() {
                              _showOverlay = false;
                              _currentPrize = null;
                            });
                          }
                        },
                        isWinning:
                            gameplayState == GameplayState.showing
                                ? null
                                : (gameplayState == GameplayState.finished &&
                                    voucher?.prizeId ==
                                        setting.prizes[index].id),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }

        return Listener(
          behavior: HitTestBehavior.opaque,
          onPointerDown: (_) {
            if (!_hasInteracted && state is Success && audioEnabled) {
              _hasInteracted = true;
              _audioPlayer.setLoopMode(LoopMode.one);
              _audioPlayer.setAudioSource(
                AudioSource.uri(Uri.parse(state.setting.audio.fileUrl)),
              );
              _audioPlayer.play();
            }
          },
          child: Scaffold(
            body: BackgroundWidget(
              imageUrl: setting.asset.backgroundImageUrl,
              child: Stack(
                children: [
                  gameView(),
                  if (gameplayState.canShowPrize) dialogView(),
                  if (gameplayState == GameplayState.verifying) LoadingWidget(),
                  audioButton(),
                  if (_showOverlay) _prizeOverlay(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
