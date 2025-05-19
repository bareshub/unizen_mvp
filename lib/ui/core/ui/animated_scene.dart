import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_scene/scene.dart';
import 'package:vector_math/vector_math.dart' as vm;

class AnimatedScene extends StatefulWidget {
  const AnimatedScene({super.key});

  @override
  State<AnimatedScene> createState() => _AnimatedSceneState();
}

class _AnimatedSceneState extends State<AnimatedScene> {
  Scene scene = Scene();
  bool loaded = false;
  AnimationClip? idleClip;
  AnimationClip? walkClip;
  AnimationClip? attackClip;

  @override
  void initState() {
    final model = Node.fromAsset('assets/toilet.glb').then((modelNode) {
      for (final animation in modelNode.parsedAnimations) {
        debugPrint('Animation: ${animation.name}');
      }

      scene.add(modelNode);

      idleClip =
          modelNode.createAnimationClip(modelNode.findAnimationByName('idle')!)
            ..loop = true
            ..play();

      walkClip =
          modelNode.createAnimationClip(modelNode.findAnimationByName('walk')!)
            ..loop = true
            ..play();

      attackClip =
          modelNode.createAnimationClip(
              modelNode.findAnimationByName('attack')!,
            )
            ..loop = true
            ..play();
    });

    Future.wait([model]).then((_) {
      debugPrint('Scene loaded');
      setState(() {
        loaded = true;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    scene.removeAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!loaded) {
      return Center(child: CircularProgressIndicator());
    }
    return SizedBox.expand(child: CustomPaint(painter: _ScenePainter(scene)));
  }
}

class _ScenePainter extends CustomPainter {
  _ScenePainter(this.scene);
  Scene scene;

  @override
  void paint(Canvas canvas, Size size) {
    const double rotationAmount = 0;
    const double distance = 6;
    final camera = PerspectiveCamera(
      position: vm.Vector3(
        sin(rotationAmount) * distance,
        2,
        cos(rotationAmount) * distance,
      ),
      target: vm.Vector3(0, 1.5, 0),
    );

    scene.render(camera, canvas, viewport: Offset.zero & size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
