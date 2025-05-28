import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:unizen/ui/animated_scene/view_models/animated_scene_view_model.dart';
import 'package:unizen/ui/animated_scene/widgets/scene_painter.dart';

class AnimatedScene extends StatefulWidget {
  const AnimatedScene({super.key, required this.viewModel});

  final AnimatedSceneViewModel viewModel;

  @override
  State<AnimatedScene> createState() => _AnimatedSceneState();
}

class _AnimatedSceneState extends State<AnimatedScene> {
  late Ticker _ticker;

  @override
  void initState() {
    super.initState();

    Future.wait([widget.viewModel.loadCommand.executeWithFuture()]).then((_) {
      _ticker = Ticker((elapsed) {
        widget.viewModel.update(elapsed);
      })..start();
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
    return ValueListenableBuilder<bool>(
      valueListenable: widget.viewModel.loadCommand.isExecuting,
      builder:
          (_, isLoaded, _) =>
              isLoaded
                  ? CircularProgressIndicator()
                  : SizedBox.expand(
                    child: GestureDetector(
                      onHorizontalDragUpdate:
                          (details) => _onHorizontalDragUpdate(details),
                      child: ValueListenableBuilder<double>(
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
                                      cameraDistance:
                                          widget
                                              .viewModel
                                              .config
                                              .cameraDistance,
                                    ),
                                  ),
                                ),
                          );
                        },
                      ),
                    ),
                  ),
    );
  }

  void _onHorizontalDragUpdate(DragUpdateDetails? details) {
    if ((details?.primaryDelta ?? 0) > 0) {
      widget.viewModel.turnRightCommand.execute();
    } else if ((details?.primaryDelta ?? 0) < 0) {
      widget.viewModel.turnLeftCommand.execute();
    }
  }
}
