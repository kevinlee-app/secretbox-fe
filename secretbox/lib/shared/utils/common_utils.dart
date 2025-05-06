import 'package:flutter/material.dart';
import 'package:secretbox/shared/utils/screen_type.dart';

abstract class CommonUtils {
  static isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 900;

  static ScreenType screenType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width < 1000
        ? ScreenType.s
        : (width >= 1000 && width <= 1500)
            ? ScreenType.m
            : ScreenType.l;
  }

  static int crossAxisCount(BuildContext context) {
    final screenType = CommonUtils.screenType(context);
    return screenType == ScreenType.s
        ? 3
        : screenType == ScreenType.m
            ? 4
            : 5;
  }

  static double aspectRatio(BuildContext context) {
    final widthMultiplier = MediaQuery.of(context).size.width * 0.002;
    final screenType = CommonUtils.screenType(context);
    return widthMultiplier * (screenType == ScreenType.s
      ? 1.9
      : screenType == ScreenType.m
          ? 1.0
          : 0.6);
  }
}
