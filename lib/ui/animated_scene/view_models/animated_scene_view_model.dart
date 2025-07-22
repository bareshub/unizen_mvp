import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_scene/scene.dart';

import '../../../domain/models/animated_scene/animated_scene.dart';

class AnimatedSceneViewModel extends ChangeNotifier {
  final Scene scene = Scene();
  final AnimatedScene model;

  late final Command<void, void> loadCommand;
  late final Command<void, void> playClipCommand;

  final ValueNotifier<double> elapsedFrames = ValueNotifier(0);
  final Map<String, AnimationClip> _animationMap = {};

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  AnimatedSceneViewModel({required this.model}) {
    loadCommand = Command.createAsyncNoParamNoResult(_loadScene);
    playClipCommand = Command.createSyncNoResult<String>(_play);
  }

  /// Returns the list of available animation names.
  List<String> get availableClips => _animationMap.keys.toList();

  /// Updates the elapsed frames for the animation.
  void update(Duration elapsed) {
    elapsedFrames.value = elapsed.inMilliseconds / 1000 * model.fps;
  }

  /// Loads the scene and its animations.
  Future<void> _loadScene() async {
    _isLoading = true;
    notifyListeners();
    try {
      final node = await Node.fromAsset(model.modelAssetPath);

      for (final animation in node.parsedAnimations) {
        _animationMap[animation.name] = _createClip(node, animation.name);
      }

      var defaultClip = _animationMap[model.defaultAnimation.name];
      if (defaultClip != null) {
        defaultClip
          ..weight = 1
          ..play();
      } else {
        debugPrint(
          'Default animation "${model.defaultAnimation.name}" not found.',
        );
      }

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

  /// Creates an animation clip for the given node and animation name.
  AnimationClip _createClip(Node node, String name) {
    var animation = node.findAnimationByName(name);
    if (animation == null) throw Exception('Animation $name not found.');
    return node.createAnimationClip(animation)
      ..loop = true
      ..weight = 0;
  }

  /// Plays the specified animation clip by name.
  void _play(String clipName) {
    if (!_animationMap.containsKey(clipName)) {
      debugPrint('Animation "$clipName" not found.');
      return;
    }
    _animationMap.forEach((key, clip) {
      if (key == clipName) {
        clip
          ..weight = 1
          ..play();
      } else {
        clip
          ..weight = 0
          ..stop();
      }
    });
    notifyListeners();
  }

  /// Resets the scene and all animations.
  void reset() {
    scene.removeAll();
    _animationMap.clear();
    elapsedFrames.value = 0;
    notifyListeners();
  }

  @override
  void dispose() {
    scene.removeAll();
    elapsedFrames.dispose();
    super.dispose();
  }
}
