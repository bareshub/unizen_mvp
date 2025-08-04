import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_scene/scene.dart';

import '../../../domain/models/static_scene/static_scene.dart';

class StaticSceneViewModel extends ChangeNotifier {
  final Scene scene = Scene();
  final StaticScene model;

  late final Command<void, void> loadCommand;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  StaticSceneViewModel({required this.model}) {
    loadCommand = Command.createAsyncNoParamNoResult(_loadScene);
  }

  /// Loads the scene and its animations.
  Future<void> _loadScene() async {
    _isLoading = true;
    notifyListeners();
    try {
      final node = await Node.fromAsset(model.modelAssetPath);

      scene.add(node);
      scene.environment
        ..exposure = model.environmentExposure
        ..intensity = model.environmentIntensity;
    } catch (e, stack) {
      debugPrint('Error loading scene: $e\n$stack');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    scene.removeAll();
    super.dispose();
  }
}
