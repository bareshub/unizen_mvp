import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_scene/scene.dart';

import '../../../domain/models/animated_scene/animated_scene.dart';
import '../view_models/animated_scene_view_model.dart';
import '../view_models/rotation_view_model.dart';
import 'animated_scene_painter.dart';

class AnimatedSceneWidget extends StatefulWidget {
  final AnimatedScene model;
  final RotationViewModel rotationViewModel;

  const AnimatedSceneWidget({
    super.key,
    required this.model,
    required this.rotationViewModel,
  });

  static Future<void> initialize() async {
    await Scene.initializeStaticResources();
  }

  @override
  State<AnimatedSceneWidget> createState() => _AnimatedSceneWidgetState();
}

class _AnimatedSceneWidgetState extends State<AnimatedSceneWidget> {
  late Ticker _ticker;
  late AnimatedSceneViewModel _viewModel;
  bool _sceneReady = false;

  @override
  void initState() {
    super.initState();

    _ticker = Ticker((elapsed) {
      _viewModel.update(elapsed);
    });

    _viewModel = AnimatedSceneViewModel(model: widget.model);
    Future.wait([_viewModel.loadCommand.executeWithFuture()]).then((_) {
      _ticker.start();

      setState(() {
        _sceneReady = true;
      });
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !_sceneReady
        ? CircularProgressIndicator()
        : ValueListenableBuilder<double>(
          valueListenable: _viewModel.elapsedFrames,
          builder: (_, elapsed, _) {
            return ValueListenableBuilder<double>(
              valueListenable: widget.rotationViewModel.rotationX,
              builder:
                  (_, rotationX, _) => RepaintBoundary(
                    child: CustomPaint(
                      painter: AnimatedScenePainter(
                        scene: _viewModel.scene,
                        elapsedTime: elapsed,
                        rotationX: rotationX,
                        cameraDistance: _viewModel.model.cameraDistance,
                      ),
                    ),
                  ),
            );
          },
        );
  }
}
