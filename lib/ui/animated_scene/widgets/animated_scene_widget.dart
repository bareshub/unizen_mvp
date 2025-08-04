import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../domain/models/exam/exam.dart';
import '../view_models/animated_scene_view_model.dart';
import 'animated_scene_painter.dart';

class AnimatedSceneWidget extends StatefulWidget {
  const AnimatedSceneWidget({super.key, required this.exam});

  final Exam exam;

  @override
  State<AnimatedSceneWidget> createState() => _AnimatedSceneWidgetState();
}

class _AnimatedSceneWidgetState extends State<AnimatedSceneWidget> {
  late Ticker _ticker;
  late AnimatedSceneViewModel viewModel;
  bool _sceneReady = false;

  @override
  void initState() {
    super.initState();

    _ticker = Ticker((elapsed) {
      viewModel.update(elapsed);
    });

    viewModel = AnimatedSceneViewModel(model: widget.exam.boss.animatedScene);
    Future.wait([viewModel.loadCommand.executeWithFuture()]).then((_) {
      _ticker.start();

      setState(() {
        _sceneReady = true;
      });
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !_sceneReady
        ? CircularProgressIndicator()
        : ValueListenableBuilder<double>(
          valueListenable: viewModel.elapsedFrames,
          builder: (_, elapsed, _) {
            return RepaintBoundary(
              child: CustomPaint(
                painter: AnimatedScenePainter(
                  scene: viewModel.scene,
                  elapsedTime: elapsed,
                  rotationX: widget.exam.rotationX,
                  cameraDistance: viewModel.model.cameraDistance,
                ),
              ),
            );
          },
        );
  }
}
