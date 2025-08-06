import 'dart:math';

import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white
          ..strokeWidth = 20.0
          ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset.zero, Offset(size.width, size.height), paint);
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

class CurvedLinePainter extends CustomPainter {
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

    final paint2 =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 24.0
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;

    final path2 = Path();
    path2.moveTo(size.width * 0.5, 0);
    // path.quadraticBezierTo(
    //   0,
    //   size.height * 0.25,
    //   size.width * 0.5,
    //   size.height * 0.5,
    // );
    // path.quadraticBezierTo(
    //   size.width,
    //   size.height * 0.75,
    //   size.width * 0.5,
    //   size.height,
    // );

    // path.quadraticBezierTo(
    //   -size.height * 0.25,
    //   size.height * 0.25,
    //   size.width * 0.5,
    //   size.height * 0.5,
    // );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
