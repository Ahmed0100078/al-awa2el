import 'package:flutter/material.dart';
import 'package:madaresco/core/SmoothPageIndicator/src/painters/indicator_painter.dart';
import 'package:madaresco/core/SmoothPageIndicator/src/painters/jumping_dot_painter.dart';

import 'indicator_effect.dart';

class JumpingDotEffect extends IndicatorEffect {
  // Defines how high the dot will jump
  final double elevation;

  const JumpingDotEffect({
    Color activeDotColor = Colors.indigo,
    this.elevation = 15.0,
    double? offset,
    double dotWidth = 16.0,
    double dotHeight = 16.0,
    double spacing = 8.0,
    double radius = 16,
    Color dotColor = Colors.grey,
    double strokeWidth = 1.0,
    PaintingStyle paintStyle = PaintingStyle.fill,
  }) :
        // assert(activeDotColor != null),
        // assert(elevation != null),
        super(
            dotWidth: dotWidth,
            dotHeight: dotHeight,
            spacing: spacing,
            radius: radius,
            strokeWidth: strokeWidth,
            paintStyle: paintStyle,
            dotColor: dotColor,
            activeDotColor: activeDotColor);

  @override
  IndicatorPainter buildPainter(int count, double offset, bool isRTL) {
    return JumpingDotPainter(
        count: count, offset: offset, effect: this, isRTL: isRTL);
  }
}
