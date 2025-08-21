import 'dart:ui';

import 'package:flutter/material.dart';

class RoadmapPaint extends StatelessWidget {
  const RoadmapPaint({
    super.key,
    required this.bossesCount,
    required this.bossHeight,
    required this.progress,
  });

  final int bossesCount;
  final double bossHeight;
  final double progress;

  @override
  Widget build(BuildContext context) {
    const extraCurveCount = 2;

    return CustomPaint(
      size: Size(0, bossHeight * (bossesCount + extraCurveCount)),
      painter: _RoadmapPainter(
        curveCount: bossesCount,
        dottedCurveCount: extraCurveCount,
        curveHeight: bossHeight,
        progress: progress,
      ),
    );
  }
}

class _RoadmapPainter extends CustomPainter {
  _RoadmapPainter({
    required this.curveCount,
    required this.dottedCurveCount,
    required this.curveHeight,
    required this.progress,
  }) : basePaint =
           Paint()
             ..strokeCap = StrokeCap.round
             ..strokeJoin = StrokeJoin.round
             ..style = PaintingStyle.stroke;

  final int curveCount;
  final int dottedCurveCount;
  final double curveHeight;
  final double progress;

  final Paint basePaint;

  @override
  void paint(Canvas canvas, Size size) {
    final roadmapPaint =
        basePaint
          ..color = Colors.white24
          ..strokeWidth = 12.0;

    final progressPaint =
        basePaint
          ..color = Colors.white54
          ..strokeWidth = 14.0;

    final dashedPaint =
        basePaint
          ..color = Colors.white24
          ..strokeWidth = 12.0;

    var x0 = 0.0;
    var y0 = size.height;

    final roadmapPath = Path();
    roadmapPath.moveTo(x0, y0);

    var y2 = y0;
    for (int i = 0; i < curveCount; i++) {
      y2 = y0 - curveHeight * (i + 1);

      roadmapPath.arcToPoint(
        Offset(x0 + size.width / 2, y2),
        radius: Radius.elliptical(5, 3),
        clockwise: (i + curveCount + dottedCurveCount) % 2 == 0,
      );
    }

    final PathMetrics metrics = roadmapPath.computeMetrics();
    final Path partialPath = Path();
    Offset? finalPoint;

    for (final PathMetric metric in metrics) {
      final double length = metric.length * progress.clamp(0.0, 1.0);
      partialPath.addPath(metric.extractPath(0, length), Offset.zero);
      if (length > 0) {
        finalPoint = metric.getTangentForOffset(length)?.position;
      }
    }

    canvas.drawPath(roadmapPath, roadmapPaint);
    canvas.drawPath(partialPath, progressPaint);
    if (finalPoint != null) {
      final pointPaint =
          Paint()
            ..color = Colors.white
            ..style = PaintingStyle.fill;
      canvas.drawOval(
        Rect.fromCenter(center: finalPoint, width: 36.0, height: 24.0),
        pointPaint,
      );
    }

    var dashedPath = Path();
    dashedPath.moveTo(x0, y2);
    var y3 = y2;
    for (var i = 0; i < dottedCurveCount; i++) {
      y3 = y2 - curveHeight * (i + 1);

      dashedPath.arcToPoint(
        Offset(x0 + size.width / 2, y3),
        radius: Radius.elliptical(5, 3),
        clockwise: i % 2 == 0,
      );
    }
    dashedPath = _createDashedPath(dashedPath, dashLength: 5, gapLength: 20);
    canvas.drawPath(dashedPath, dashedPaint);
  }

  Path _createDashedPath(
    Path source, {
    required double dashLength,
    required double gapLength,
  }) {
    final Path dest = Path();
    for (final metric in source.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        final double next = distance + dashLength;
        dest.addPath(
          metric.extractPath(distance, next.clamp(0, metric.length)),
          Offset.zero,
        );
        distance = next + dashLength + gapLength;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
