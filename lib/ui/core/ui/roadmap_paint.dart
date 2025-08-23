import 'dart:ui';

import 'package:flutter/material.dart';

/// A widget that draws the roadmap and exposes the final point
/// (the point representing current progress along the roadmap)
/// via a [ValueNotifier].
///
/// Use [progressNotifier] to drive the painted progress (0.0 - 1.0).
class RoadmapProgressWidget extends StatelessWidget {
  RoadmapProgressWidget({
    super.key,
    required this.bossesCount,
    required this.bossHeight,
    required this.progress,
  }) : finalPointNotifier = ValueNotifier(null),
       super();

  static const extraCurveCount = 2;

  final int bossesCount;
  final double bossHeight;
  final double progress;
  final ValueNotifier<Offset?> finalPointNotifier;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(0, bossHeight * (bossesCount + extraCurveCount)),
      painter: _RoadmapProgressPainter(
        curveCount: bossesCount,
        dottedCurveCount: extraCurveCount,
        curveHeight: bossHeight,
        progress: progress,
        finalPointNotifier: finalPointNotifier,
      ),
    );
  }
}

class _RoadmapProgressPainter extends CustomPainter {
  _RoadmapProgressPainter({
    required this.curveCount,
    required this.dottedCurveCount,
    required this.curveHeight,
    required this.progress,
    required this.finalPointNotifier,
  }) : _basePaint =
           Paint()
             ..strokeCap = StrokeCap.round
             ..strokeJoin = StrokeJoin.round
             ..style = PaintingStyle.stroke,
       super();

  final int curveCount;
  final int dottedCurveCount;
  final double curveHeight;

  final double progress;
  final ValueNotifier<Offset?> finalPointNotifier;
  final Paint _basePaint;

  double get _progress => progress.clamp(0.0, 1.0);

  @override
  void paint(Canvas canvas, Size size) {
    final Offset start = Offset(0.0, size.height);

    var roadmapPath = buildRoadmapPath(size, start);
    var progressPath = buildProgressPath(roadmapPath);
    var dashedPath = buildDashedPath(size, start, dashLength: 5, gapLength: 20);

    drawRoadmap(canvas, roadmapPath);
    drawProgress(canvas, progressPath);
    drawDashed(canvas, dashedPath);

    if (finalPointNotifier.value != null) {
      drawProgressPoint(
        canvas,
        finalPointNotifier.value!,
        width: 36.0, // TODO replace with a parameter with a default value
        height: 24.0, // TODO replace with a parameter with a default value
      );
    }
  }

  Path buildRoadmapPath(Size size, Offset start) {
    final roadmapPath = Path()..moveTo(start.dx, start.dy);

    var y2 = start.dy;
    for (int i = 0; i < curveCount; i++) {
      y2 = start.dy - curveHeight * (i + 1);

      roadmapPath.arcToPoint(
        Offset(start.dx + size.width / 2, y2),
        radius: const Radius.elliptical(5, 3),
        clockwise: i % 2 != 0,
      );
    }

    return roadmapPath;
  }

  Path buildProgressPath(Path roadmapPath) {
    final PathMetrics metrics = roadmapPath.computeMetrics();
    final Path progressPath = Path();
    Offset? finalPoint;

    for (final PathMetric metric in metrics) {
      final double length = metric.length * _progress;
      if (length > 0) {
        progressPath.addPath(metric.extractPath(0, length), Offset.zero);
        finalPoint = metric.getTangentForOffset(length)?.position;
      }
    }

    if (finalPointNotifier.value != finalPoint) {
      finalPointNotifier.value = finalPoint;
    }

    return progressPath;
  }

  Path buildDashedPath(
    Size size,
    Offset start, {
    required double dashLength,
    required double gapLength,
  }) {
    var extraPath = Path();

    final y2 = start.dy - curveHeight * curveCount;
    extraPath.moveTo(start.dx, y2);
    var y3 = y2;
    for (var i = 0; i < dottedCurveCount; i++) {
      y3 = y2 - curveHeight * (i + 1);

      extraPath.arcToPoint(
        Offset(start.dx + size.width / 2, y3),
        radius: const Radius.elliptical(5, 3),
        clockwise: (i + curveCount) % 2 != 0,
      );
    }

    final Path dashedPath = Path();
    for (final metric in extraPath.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        final double next = (distance + dashLength).clamp(0.0, metric.length);
        dashedPath.addPath(metric.extractPath(distance, next), Offset.zero);
        distance = next + gapLength;
      }
    }
    return dashedPath;
  }

  void drawRoadmap(Canvas canvas, Path roadmapPath) {
    final roadmapPaint =
        _basePaint
          ..color =
              Colors
                  .white24 // TODO substitute with an optional parameter with a default value
          ..strokeWidth =
              12.0; // TODO substitute with an optional parameter with a default value
    canvas.drawPath(roadmapPath, roadmapPaint);
  }

  void drawProgress(Canvas canvas, Path progressPath) {
    final progressPaint =
        _basePaint
          ..color =
              Colors
                  .white54 // TODO substitute with an optional parameter with a default value
          ..strokeWidth =
              14.0; // TODO substitute with an optional parameter with a default value

    canvas.drawPath(progressPath, progressPaint);
  }

  void drawDashed(Canvas canvas, Path dashedPath) {
    final dashedPaint =
        _basePaint
          ..color =
              Colors
                  .white24 // TODO substitute with an optional parameter with a default value
          ..strokeWidth =
              12.0; // TODO substitute with an optional parameter with a default value

    canvas.drawPath(dashedPath, dashedPaint);
  }

  void drawProgressPoint(
    Canvas canvas,
    Offset center, {
    required double width,
    required double height,
  }) {
    final pointPaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromCenter(center: center, width: width, height: height),
      pointPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RoadmapProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.curveCount != curveCount ||
        oldDelegate.curveHeight != curveHeight ||
        oldDelegate.dottedCurveCount != dottedCurveCount;
  }
}
