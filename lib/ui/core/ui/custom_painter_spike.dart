import 'dart:ui';

import 'package:flutter/material.dart';

/// Custom painter for curved zigzag paths used in UI decorations.
class CurvedZigZagPainter extends CustomPainter {
  CurvedZigZagPainter({required this.curveCount, required this.curveHeight});

  final int curveCount;
  final double curveHeight;

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white24
          ..strokeWidth = 12.0
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..style = PaintingStyle.stroke;

    final path = Path();

    final paint2 =
        Paint()
          ..color = Colors.white54
          ..strokeWidth = 14.0
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..style = PaintingStyle.stroke;

    final paint3 =
        Paint()
          ..color = Colors.white70
          ..strokeWidth = 32.0
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..style = PaintingStyle.stroke;

    var x0 = 0.0;
    var y0 = size.height;

    canvas.drawPoints(PointMode.points, [Offset(x0, y0)], paint3);

    path.moveTo(x0, y0);

    for (int i = 0; i < curveCount; i++) {
      final y2 = y0 - curveHeight * (i + 1);

      path.arcToPoint(
        Offset(x0 + size.width / 2, y2),
        radius: Radius.elliptical(7, 4),
        clockwise: i % 2 == 0,
      );
    }

    double progress = 0.3;
    final PathMetrics metrics = path.computeMetrics();
    final Path partialPath = Path();
    for (final PathMetric metric in metrics) {
      final double length = metric.length * progress.clamp(0.0, 1.0);
      partialPath.addPath(metric.extractPath(0, length), Offset.zero);
    }
    canvas.drawPath(path, paint);
    canvas.drawPath(partialPath, paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
