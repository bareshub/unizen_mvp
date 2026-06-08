import 'package:flutter/material.dart';
import 'package:command_it/command_it.dart';
import 'package:flutter_scene/scene.dart';
import 'package:vector_math/vector_math.dart' as vm;

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
      scene.exposure = model.environmentExposure;
      scene.environmentIntensity = model.environmentIntensity;
      scene.directionalLight = DirectionalLight(direction: vm.Vector3(1, 0.5, 1));
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
