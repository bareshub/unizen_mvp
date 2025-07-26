import 'package:flutter/material.dart';
import 'package:flutter_scene/scene.dart';
import 'package:vector_math/vector_math.dart' as vm;

class StaticScenePainter extends CustomPainter {
  final Scene scene;
  final double cameraDistance;

  const StaticScenePainter({required this.scene, required this.cameraDistance});

  @override
  void paint(Canvas canvas, Size size) {
    final camera = PerspectiveCamera(
      position: vm.Vector3(0, 2, cameraDistance),
      target: vm.Vector3.zero(),
    );

    final viewport = Rect.fromLTRB(0, 0, size.width, size.height * 2);

    scene.render(camera, canvas, viewport: viewport);
  }

  @override
  bool shouldRepaint(covariant StaticScenePainter oldDelegate) {
    return false;
  }
}
