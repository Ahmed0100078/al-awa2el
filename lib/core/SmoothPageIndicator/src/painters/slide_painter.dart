import 'package:flutter/material.dart';
import 'package:madaresco/core/SmoothPageIndicator/src/effects/slide_effect.dart';

import 'indicator_painter.dart';

class SlidePainter extends IndicatorPainter {
  final SlideEffect effect;

  SlidePainter({
    required this.effect,
    required int count,
    required double offset,
    required bool isRTL,
  }) : super(offset, count, effect, isRTL);

  @override
  void paint(Canvas canvas, Size size) {
    // paint still dots
    super.paint(canvas, size);

    final activePaint = Paint()..color = effect.activeDotColor;
    final xPos = effect.strokeWidth / 2 + (offset * distance);
    final yPos = size.height / 2;
    final rRect = RRect.fromLTRBR(
      xPos,
      yPos - effect.dotHeight / 2,
      xPos + effect.dotWidth,
      yPos + effect.dotHeight / 2,
      dotRadius,
    );

    canvas.drawRRect(rRect, activePaint);
  }
}
