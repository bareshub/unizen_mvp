import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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

  late Ticker ticker;
  double elapsedSeconds = 0;

  void printNodeHierarchy(Node node, [String indent = '']) {
    debugPrint('$indent- ${node.name}');
    for (final child in node.children) {
      printNodeHierarchy(child, '$indent  ');
    }
  }

  @override
  void initState() {
    ticker = Ticker((elapsed) {
      setState(() {
        elapsedSeconds = elapsed.inMilliseconds.toDouble() / 1000;
      });
    });
    ticker.start();

    final model = Node.fromAsset(
      'build/models/zombie_after_blender.model',
    ).then((modelNode) {
      for (final animation in modelNode.parsedAnimations) {
        debugPrint('Animation: ${animation.name}');
      }

      printNodeHierarchy(modelNode);

      scene.add(modelNode);

      idleClip =
          modelNode.createAnimationClip(modelNode.findAnimationByName('idle')!)
            ..loop = true
            ..play();

      // walkClip =
      //     modelNode.createAnimationClip(modelNode.findAnimationByName('walk')!)
      //       ..loop = true
      //       ..play();
      // attackClip =
      //     modelNode.createAnimationClip(
      //         modelNode.findAnimationByName('attack')!,
      //       )
      //       ..loop = true
      //       ..play();
    });

    Future.wait([model]).then((_) {
      debugPrint('Scene loaded');
      Scene.initializeStaticResources().then((_) {
        setState(() {
          loaded = true;
        });
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
    return SizedBox.expand(
      child: CustomPaint(painter: _ScenePainter(scene, elapsedSeconds)),
    );
  }
}

class _ScenePainter extends CustomPainter {
  _ScenePainter(this.scene, this.elapsedTime);
  Scene scene;
  double elapsedTime;

  @override
  void paint(Canvas canvas, Size size) {
    double rotationAmount = elapsedTime * 0.5;
    const double distance = 10;
    final camera = PerspectiveCamera(
      position: vm.Vector3(
        sin(rotationAmount) * distance,
        2,
        cos(rotationAmount) * distance,
      ),
      target: vm.Vector3(0, 1, 0),
    );

    scene.render(camera, canvas, viewport: Offset.zero & size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
