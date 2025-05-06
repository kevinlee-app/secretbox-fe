import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secretbox/features/game/presentation/providers/game_state_provider.dart';
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
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameStateNotifierProvider);

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
      ) {
        Widget dialogView() {
          return SizedBox.expand(
            child: Container(
              color: AppColors.black38,
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
                          width: MediaQuery.of(context).size.width * 0.25,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),

                          child: TextField(
                            textAlign: TextAlign.center,
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
                                        .read(voucherCodeProvider.notifier)
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
                                  final code = ref.read(voucherCodeProvider);
                                  ref
                                      .read(gameStateNotifierProvider.notifier)
                                      .getVoucher(code);
                                },
                              ),

                            const SizedBox(width: 16),
                            if (gameplayState.canShowPrize)
                              ButtonWidget(
                                text: AppStrings.showPrizes,
                                color: Colors.red,
                                onPressed:
                                    ref
                                        .read(
                                          gameStateNotifierProvider.notifier,
                                        )
                                        .showAllPrizes,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
                onPressed:
                    ref
                        .read(gameStateNotifierProvider.notifier)
                        .showVoucherInput,
              ),
              SizedBox(height: 20),
            ],
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
                        prize: setting.prizes[index].name,
                        canOpen:
                            gameplayState == GameplayState.choosing &&
                            !shouldReveal,
                        boxState:
                            shouldReveal ? BoxState.opened : boxStates[index],
                        onOpened:
                            () => ref
                                .read(gameStateNotifierProvider.notifier)
                                .revealPrize(index),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }

        return Scaffold(
          body: BackgroundWidget(
            imageUrl: setting.asset.backgroundImageUrl,
            child: Stack(
              children: [
                gameView(),
                if (gameplayState.canShowPrize) dialogView(),
                if (gameplayState == GameplayState.verifying) LoadingWidget(),
              ],
            ),
          ),
        );
      },
    );
  }
}
