import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:unizen/domain/models/avatar/avatar.dart';

import '../../../domain/models/exam/exam.dart';
import '../view_models/animated_scene_view_model.dart';
import 'animated_scene_painter.dart';

class AnimatedSceneWidget extends StatefulWidget {
  const AnimatedSceneWidget.avatar({super.key, required this.avatar})
    : assert(avatar != null),
      exam = null;

  const AnimatedSceneWidget.boss({super.key, required this.exam})
    : assert(exam != null),
      avatar = null;

  final Avatar? avatar;
  final Exam? exam;

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

    assert(widget.avatar != null || widget.exam != null);
    viewModel = AnimatedSceneViewModel(
      model: widget.avatar?.animatedScene ?? widget.exam!.boss.animatedScene,
    );

    _ticker = Ticker((elapsed) {
      viewModel.update(elapsed);
    });

    Future.wait([viewModel.loadCommand.runAsync()]).then((_) {
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
                  rotationX: widget.exam?.rotationX ?? 0.0,
                  cameraDistance: viewModel.model.cameraDistance,
                  flip: viewModel.model.flip,
                ),
              ),
            );
          },
        );
  }
}
