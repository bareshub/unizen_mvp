import 'package:flutter/material.dart';
import 'package:flutter_scene/scene.dart';
import 'package:unizen/ui/static_scene/view_models/static_scene_view_model.dart';

import '../../../domain/models/static_scene/static_scene.dart';
import 'static_scene_painter.dart';

class StaticSceneWidget extends StatefulWidget {
  final StaticScene model;

  const StaticSceneWidget({super.key, required this.model});

  static Future<void> initialize() async {
    await Scene.initializeStaticResources();
  }

  @override
  State<StaticSceneWidget> createState() => _StaticSceneWidgetState();
}

class _StaticSceneWidgetState extends State<StaticSceneWidget> {
  late StaticSceneViewModel _viewModel;
  bool _sceneReady = false;

  @override
  void initState() {
    super.initState();

    _viewModel = StaticSceneViewModel(model: widget.model);
    Future.wait([_viewModel.loadCommand.executeWithFuture()]).then((_) {
      setState(() {
        _sceneReady = true;
      });
    });
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !_sceneReady
        ? CircularProgressIndicator()
        : CustomPaint(
          painter: StaticScenePainter(
            scene: _viewModel.scene,
            cameraDistance: widget.model.cameraDistance,
          ),
        );
  }
}
