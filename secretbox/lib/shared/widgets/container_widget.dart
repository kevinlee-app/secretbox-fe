import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  final Widget child;
  const ContainerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        padding: EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              offset: Offset(2, 4),
              blurRadius: 8,
              spreadRadius: 2,
              color: Colors.white24,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [child],
        ),
      ),
    );
  }
}
