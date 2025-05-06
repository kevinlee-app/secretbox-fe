import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secretbox/shared/theme/app_colors.dart';
import 'package:secretbox/shared/theme/text_styles.dart';

class ButtonWidget extends ConsumerWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const ButtonWidget({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(150, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: color,
        foregroundColor: AppColors.black,
        textStyle: AppTextStyles.bodyLg.copyWith(fontWeight: FontWeight.bold),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
