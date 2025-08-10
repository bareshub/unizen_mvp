import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class ZigZagPainter extends CustomPainter {
  final int linesCount;
  final double curveHeight;

  ZigZagPainter({required this.linesCount, required this.curveHeight});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white38
          ..strokeWidth = 12.0
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..style = PaintingStyle.stroke;

    final path = Path();

    path.moveTo(0, 0);
    for (int i = 0; i < linesCount; i++) {
      final x = (i % 2 == 0) ? size.width : 0.0;
      final y = curveHeight * (i + 1);
      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

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

class RectanglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 20.0
          ..strokeJoin = StrokeJoin.round;

    final rect = Rect.fromLTRB(40, 40, 200, 120);

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 20.0;

    final center = Offset(size.shortestSide / 2, size.shortestSide / 2);
    final radius = size.shortestSide / 4;
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ConicToPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white54
          ..style = PaintingStyle.stroke
          ..strokeWidth = 24.0
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;

    final path = Path();
    path.moveTo(size.width * 0.5, 0);

    final destinationPoint1 = Point(size.width * 0.5, size.height * 1 / 3);
    final controlPoint1 = Point(0 - size.width * 3, destinationPoint1.y / 2);

    final destinationPoint2 = Point(size.width * 0.5, size.height * 2 / 3);
    final controlPoint2 = Point(
      size.width + size.width * 3,
      destinationPoint1.y + (destinationPoint2.y - destinationPoint1.y) / 2,
    );

    final destinationPoint3 = Point(size.width * 0.5, size.height);
    final controlPoint3 = Point(
      0 - size.width * 3,
      destinationPoint2.y + (destinationPoint3.y - destinationPoint2.y) / 2,
    );

    path.conicTo(
      controlPoint1.x,
      controlPoint1.y,
      destinationPoint1.x,
      destinationPoint1.y,
      0.1,
    );

    path.conicTo(
      controlPoint2.x,
      controlPoint2.y,
      destinationPoint2.x,
      destinationPoint2.y,
      0.1,
    );

    path.conicTo(
      controlPoint3.x,
      controlPoint3.y,
      destinationPoint3.x,
      destinationPoint3.y,
      0.1,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ArcToPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white54
          ..style = PaintingStyle.stroke
          ..strokeWidth = 24.0
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;

    final path = Path();
    path.moveTo(size.width * 0.5, 0);

    path.arcToPoint(
      Offset(size.width * 0.5, size.height * 0.35),
      radius: Radius.circular(1.0),
      clockwise: false,
    );
    path.arcToPoint(
      Offset(size.width * 0.5, size.height * 0.70),
      radius: Radius.circular(1.0),
      clockwise: true,
    );
    path.arcToPoint(
      Offset(size.width * 0.5, size.height * 1.05),
      radius: Radius.circular(1.0),
      clockwise: false,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
