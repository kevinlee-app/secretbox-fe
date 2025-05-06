import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:secretbox/shared/widgets/container_widget.dart';
import 'package:secretbox/shared/domain/models/box_state.dart';
import 'package:secretbox/shared/theme/app_colors.dart';
import 'package:secretbox/shared/theme/text_styles.dart';

class BoxWidget extends StatefulWidget {
  final String prize;
  final bool canOpen;
  final BoxState boxState;
  final VoidCallback onOpened;

  const BoxWidget({
    super.key,
    required this.prize,
    required this.canOpen,
    required this.boxState,
    required this.onOpened,
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

  void _openBox() {
    if (!widget.canOpen) return;
    widget.onOpened();

    Future.delayed(const Duration(milliseconds: 600), () {
      _confettiController.play();
    });
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
                        Image.asset('assets/images/box_opened.png'),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: ContainerWidget(
                            child: Text(
                              widget.prize,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.h3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  : widget.boxState == BoxState.spinning
                  ? RotationTransition(
                    turns: _spinAnimation,
                    child: Image.asset('assets/images/box_closed.png'),
                  )
                  : ScaleTransition(
                    scale: _scaleAnimation,
                    child: Image.asset('assets/images/box_closed.png'),
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
