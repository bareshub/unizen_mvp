import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_scene/scene.dart';
import 'package:vector_math/vector_math.dart' as vm;

class AnimatedScenePainter extends CustomPainter {
  final Scene scene;
  final double elapsedTime;
  final double rotationX;
  final double cameraDistance;
  final bool showBack;

  const AnimatedScenePainter({
    required this.scene,
    required this.elapsedTime,
    required this.rotationX,
    required this.cameraDistance,
    this.showBack = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final camera = PerspectiveCamera(
      position: vm.Vector3(
        sin(rotationX) * cameraDistance,
        2,
        cos(rotationX) * cameraDistance * (showBack ? -1 : 1),
      ),
      target: vm.Vector3.zero(),
    );

    final viewport = Rect.fromLTRB(0, 0, size.width, size.height * 2);

    scene.render(camera, canvas, viewport: viewport);
  }

  @override
  bool shouldRepaint(covariant AnimatedScenePainter oldDelegate) {
    return oldDelegate.elapsedTime != elapsedTime;
  }
}
