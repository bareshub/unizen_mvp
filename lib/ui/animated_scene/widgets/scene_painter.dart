import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_scene/scene.dart';
import 'package:vector_math/vector_math.dart' as vm;

class ScenePainter extends CustomPainter {
  final Scene scene;
  final double elapsedTime;
  final double rotationX;
  final double cameraDistance;

  const ScenePainter({
    required this.scene,
    required this.elapsedTime,
    required this.rotationX,
    required this.cameraDistance,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final camera = PerspectiveCamera(
      position: vm.Vector3(
        sin(rotationX) * cameraDistance,
        2,
        cos(rotationX) * cameraDistance,
      ),
      target: vm.Vector3.zero(),
    );

    final viewport = Rect.fromLTRB(0, 0, size.width, size.height * 2);

    scene.render(camera, canvas, viewport: viewport);
  }

  @override
  bool shouldRepaint(covariant ScenePainter oldDelegate) {
    return oldDelegate.elapsedTime != elapsedTime;
  }
}
