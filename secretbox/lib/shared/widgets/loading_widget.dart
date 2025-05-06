import 'package:flutter/material.dart';
import 'package:secretbox/shared/theme/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: AppColors.black38,
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
