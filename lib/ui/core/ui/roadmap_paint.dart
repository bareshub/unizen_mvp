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
    ValueNotifier<Offset?>? finalPointNotifier,
  }) : finalPointNotifier = finalPointNotifier ?? ValueNotifier(null);

  final int bossesCount;
  final double bossHeight;
  final double progress;
  final ValueNotifier<Offset?> finalPointNotifier;

  @override
  Widget build(BuildContext context) {
    const extraCurveCount = 2;

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
    final roadmapPaint =
        _basePaint
          ..color = Colors.white24
          ..strokeWidth = 12.0;

    final progressPaint =
        _basePaint
          ..color = Colors.white54
          ..strokeWidth = 14.0;

    final dashedPaint =
        _basePaint
          ..color = Colors.white24
          ..strokeWidth = 12.0;

    final x0 = 0.0;
    var y0 = size.height;

    final roadmapPath = Path()..moveTo(x0, y0);

    var y2 = y0;
    for (int i = 0; i < curveCount; i++) {
      y2 = y0 - curveHeight * (i + 1);

      roadmapPath.arcToPoint(
        Offset(x0 + size.width / 2, y2),
        radius: const Radius.elliptical(5, 3),
        clockwise: (i + curveCount + dottedCurveCount) % 2 == 0,
      );
    }

    final PathMetrics metrics = roadmapPath.computeMetrics();
    final Path partialPath = Path();
    Offset? finalPoint;

    for (final PathMetric metric in metrics) {
      final double length = metric.length * _progress;
      if (length > 0) {
        partialPath.addPath(metric.extractPath(0, length), Offset.zero);
        finalPoint = metric.getTangentForOffset(length)?.position;
      }
    }

    // Update final point notifier if it changed
    if (finalPointNotifier.value != finalPoint) {
      // Avoid notifying during paint if caller expects no rebuild loops, but
      // this usage is common to expose data computed by the painter.
      finalPointNotifier.value = finalPoint;
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

    // Draw dotted extension
    var dashedPath = Path();
    dashedPath.moveTo(x0, y2);
    var y3 = y2;
    for (var i = 0; i < dottedCurveCount; i++) {
      y3 = y2 - curveHeight * (i + 1);

      dashedPath.arcToPoint(
        Offset(x0 + size.width / 2, y3),
        radius: const Radius.elliptical(5, 3),
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
        final double next = (distance + dashLength).clamp(0.0, metric.length);
        dest.addPath(metric.extractPath(distance, next), Offset.zero);
        distance = next + gapLength;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant _RoadmapProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.curveCount != curveCount ||
        oldDelegate.curveHeight != curveHeight ||
        oldDelegate.dottedCurveCount != dottedCurveCount;
  }
}
