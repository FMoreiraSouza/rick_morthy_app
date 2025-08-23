import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rick_morthy_app/core/constants/responsivity_contants.dart';

class ResponsivityUtils {
  final BuildContext context;

  ResponsivityUtils(this.context);

  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;
  double get shortestSide => MediaQuery.of(context).size.shortestSide;
  double get longestSide => MediaQuery.of(context).size.longestSide;
  double get statusBarHeight => MediaQuery.of(context).padding.top;
  double get bottomInset => MediaQuery.of(context).padding.bottom;

  double responsiveSize(double percentage, double maxValue) {
    return min(shortestSide * percentage, maxValue);
  }

  EdgeInsets responsivePadding({
    double horizontalPercentage = 0.0,
    double verticalPercentage = 0.0,
    double? horizontalBase,
    double? verticalBase,
  }) {
    return EdgeInsets.symmetric(
      horizontal: horizontalBase ?? shortestSide * horizontalPercentage,
      vertical: verticalBase ?? shortestSide * verticalPercentage,
    );
  }

  EdgeInsets responsiveAllPadding(double percentage) {
    final value = shortestSide * percentage;
    return EdgeInsets.all(value);
  }

  BorderRadius responsiveBorderRadius(double percentage) {
    return BorderRadius.circular(shortestSide * percentage);
  }

  double defaultSpacing({double multiplier = 1.0}) {
    return responsiveSize(
      ResponsivityConstants.defaultSpacingPercentage * multiplier,
      ResponsivityConstants.defaultSpacingBase * multiplier,
    );
  }

  double smallSpacing() {
    return responsiveSize(
      ResponsivityConstants.smallSpacingPercentage,
      ResponsivityConstants.defaultSpacingBase * 0.5,
    );
  }

  double largeSpacing() {
    return responsiveSize(
      ResponsivityConstants.largeSpacingPercentage,
      ResponsivityConstants.largeSpacingBase,
    );
  }

  double imageSize() {
    return responsiveSize(
      ResponsivityConstants.imageSizePercentage,
      ResponsivityConstants.imageSizeBase,
    );
  }

  double listTileImageSize() {
    return responsiveSize(
      ResponsivityConstants.listTileImageSizePercentage,
      ResponsivityConstants.listTileImageSizeBase,
    );
  }

  double iconSize() {
    return responsiveSize(
      ResponsivityConstants.iconSizePercentage,
      ResponsivityConstants.iconSizeBase,
    );
  }

  double textSize() {
    return responsiveSize(
      ResponsivityConstants.textSizePercentage,
      ResponsivityConstants.textSizeBase,
    );
  }
}
