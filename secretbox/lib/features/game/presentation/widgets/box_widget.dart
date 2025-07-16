import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:secretbox/shared/domain/models/asset.dart';
import 'package:secretbox/shared/domain/models/prize.dart';
import 'package:secretbox/shared/widgets/container_widget.dart';
import 'package:secretbox/shared/domain/models/box_state.dart';
import 'package:secretbox/shared/theme/text_styles.dart';

class BoxWidget extends StatefulWidget {
  final Prize prize;
  final Asset asset;
  final bool canOpen;
  final BoxState boxState;
  final VoidCallback onOpened;
  final bool? isWinning;

  const BoxWidget({
    super.key,
    required this.prize,
    required this.asset,
    required this.canOpen,
    required this.boxState,
    required this.onOpened,
    required this.isWinning,
  });

  @override
  State<BoxWidget> createState() => _BoxWidgetState();
}

class _BoxWidgetState extends State<BoxWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _spinAnimation;
  late ConfettiController _confettiController;
  ImageProvider? _closedImageProvider;
  ImageProvider? _openedImageProvider;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _spinAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 1),
    );

    if (widget.boxState == BoxState.closed) {
      _controller.repeat(reverse: true); // Pulse animation for the closed state
    }
  }

  @override
  void didUpdateWidget(covariant BoxWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.boxState == BoxState.spinning) {
      _controller.repeat(reverse: false);
    } else if (widget.boxState == BoxState.opened) {
      _controller.stop();
    } else if (widget.boxState == BoxState.closed) {
      _controller.reset();
      _controller.repeat(reverse: true); // Pulse animation
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _closedImageProvider = CachedNetworkImageProvider(
      widget.asset.boxClosedUrl,
    );
    _openedImageProvider = CachedNetworkImageProvider(
      widget.asset.boxOpenedUrl,
    );

    precacheImage(_closedImageProvider!, context);
    precacheImage(_openedImageProvider!, context);
  }

  void _openBox() {
    if (!widget.canOpen) return;
    widget.onOpened();

    _confettiController.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: widget.boxState == BoxState.spinning ? null : _openBox,
          child:
              widget.boxState == BoxState.opened
                  ? ScaleTransition(
                    scale: _scaleAnimation,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        _openedImageProvider != null
                            ? Image(
                              image: _openedImageProvider!,
                              color: Colors.white.withOpacity(
                                (widget.isWinning == null ||
                                        widget.isWinning == true)
                                    ? 1.0
                                    : 0.5,
                              ),
                              colorBlendMode: BlendMode.modulate,
                            )
                            : const SizedBox.shrink(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: FittedBox(
                            child: ContainerWidget(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  LayoutBuilder(
                                    builder: (context, constraints) {
                                      // Get screen width
                                      final screenWidth =
                                          MediaQuery.of(context).size.width;

                                      // Set the desired image size based on screen width
                                      final imageSize =
                                          screenWidth *
                                          0.1; // 60% of screen width, adjust as needed

                                      return SizedBox(
                                        width: imageSize,
                                        height: imageSize,
                                        child: CachedNetworkImage(
                                          imageUrl: widget.prize.imageUrl,
                                          fit: BoxFit.contain,
                                          color: Colors.white.withOpacity(
                                            (widget.isWinning == null ||
                                                    widget.isWinning == true)
                                                ? 1.0
                                                : 0.5,
                                          ),
                                          colorBlendMode: BlendMode.modulate,
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 8),
                                  Flexible(
                                    child: Text(
                                      widget.prize.name,
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.h3,
                                      softWrap: true,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  : widget.boxState == BoxState.spinning
                  ? RotationTransition(
                    turns: _spinAnimation,
                    child:
                        _closedImageProvider != null
                            ? Image(image: _closedImageProvider!)
                            : const SizedBox.shrink(),
                  )
                  : ScaleTransition(
                    scale: _scaleAnimation,
                    child:
                        _closedImageProvider != null
                            ? Image(image: _closedImageProvider!)
                            : const SizedBox.shrink(),
                  ),
        ),
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: false,
          colors: [
            Colors.yellow,
            Colors.red,
            Colors.blue,
            Colors.green,
            Colors.purple,
          ],
          numberOfParticles: 30,
          maxBlastForce: 20,
          minBlastForce: 5,
          emissionFrequency: 0.05,
        ),
      ],
    );
  }
}
