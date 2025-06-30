import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_scene/scene.dart';

import '../view_models/animated_scene_view_model.dart';
import '../widgets/scene_painter.dart';

class AnimatedScene extends StatefulWidget {
  const AnimatedScene({super.key, required this.viewModel});

  final AnimatedSceneViewModel viewModel;

  static Future<void> initialize() async {
    await Scene.initializeStaticResources();
  }

  @override
  State<AnimatedScene> createState() => _AnimatedSceneState();
}

class _AnimatedSceneState extends State<AnimatedScene> {
  late Ticker _ticker;
  bool _sceneReady = false;

  @override
  void initState() {
    super.initState();

    Future.wait([widget.viewModel.loadCommand.executeWithFuture()]).then((_) {
      _ticker = Ticker((elapsed) {
        widget.viewModel.update(elapsed);
      })..start();

      setState(() {
        _sceneReady = true;
      });
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    widget.viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !_sceneReady
        ? CircularProgressIndicator()
        : ValueListenableBuilder<double>(
          valueListenable: widget.viewModel.elapsedFrames,
          builder: (_, elapsed, _) {
            return ValueListenableBuilder<double>(
              valueListenable: widget.viewModel.rotationX,
              builder:
                  (_, rotX, _) => RepaintBoundary(
                    child: CustomPaint(
                      painter: ScenePainter(
                        scene: widget.viewModel.scene,
                        elapsedTime: elapsed,
                        rotationX: rotX,
                        cameraDistance: widget.viewModel.config.cameraDistance,
                      ),
                    ),
                  ),
            );
          },
        );
  }
}
