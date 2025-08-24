import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../roadmap_screen/view_models/roadmap_progress_view_model.dart';

/// A widget that draws the roadmap and exposes the current point
/// (the point representing current progress along the roadmap)
/// via a [ValueNotifier].
///
/// Use [progress] to drive the painted progress (0.0 - 1.0).
class RoadmapProgressWidget extends StatelessWidget {
  const RoadmapProgressWidget({
    super.key,
    required this.bossesCount,
    required this.bossHeight,
    required this.progress,
    required this.viewModel,
  });

  static const extraCurveCount = 2;

  final int bossesCount;
  final double bossHeight;
  final double progress;
  final RoadmapProgressViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(0, bossHeight * (bossesCount + extraCurveCount)),
      painter: _RoadmapProgressPainter(
        curveCount: bossesCount,
        dottedCurveCount: extraCurveCount,
        curveHeight: bossHeight,
        progress: progress,
        viewModel: viewModel,
      ),
    );
  }
}

class _RoadmapProgressPainter extends CustomPainter {
  _RoadmapProgressPainter({
    required this.curveCount,
    required this.curveHeight,
    required this.dottedCurveCount,
    required this.progress,
    required this.viewModel,
  }) : _basePaint =
           Paint()
             ..strokeCap = StrokeCap.round
             ..strokeJoin = StrokeJoin.round
             ..style = PaintingStyle.stroke,
       super();

  static const double currentPointWidth = 36.0;
  static const double currentPointHeight = 24.0;
  static const Color roadmapPaintColor = Colors.white24;
  static const double roadmapPaintStrokeWidth = 12.0;
  static const Color progressPaintColor = Colors.white54;
  static const double progressPaintStrokeWidth = 14.0;

  final int curveCount;
  final double curveHeight;
  final int dottedCurveCount;

  final double progress;
  final RoadmapProgressViewModel viewModel;
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

    if (viewModel.currentPoint != null) {
      drawCurrentPoint(
        canvas,
        viewModel.currentPoint!,
        width: currentPointWidth,
        height: currentPointHeight,
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

    // Schedule a post-frame update to set the current point on the view model.
    if (viewModel.currentPoint != finalPoint) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        // viewModel will notify listeners from the main thread.
        viewModel.setCurrentPoint(finalPoint);
      });
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
          ..color = roadmapPaintColor
          ..strokeWidth = roadmapPaintStrokeWidth;
    canvas.drawPath(roadmapPath, roadmapPaint);
  }

  void drawProgress(Canvas canvas, Path progressPath) {
    final progressPaint =
        _basePaint
          ..color = progressPaintColor
          ..strokeWidth = progressPaintStrokeWidth;

    canvas.drawPath(progressPath, progressPaint);
  }

  void drawDashed(Canvas canvas, Path dashedPath) {
    final dashedPaint =
        _basePaint
          ..color = roadmapPaintColor
          ..strokeWidth = roadmapPaintStrokeWidth;

    canvas.drawPath(dashedPath, dashedPaint);
  }

  void drawCurrentPoint(
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
