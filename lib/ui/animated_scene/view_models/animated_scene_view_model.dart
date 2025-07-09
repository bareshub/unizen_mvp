import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_scene/scene.dart';

import '../configs/scene_config.dart';

class AnimatedSceneViewModel extends ChangeNotifier {
  final Scene scene = Scene();
  final SceneConfig config;

  late final Command<void, void> loadCommand;
  late final Command<void, void> turnRightCommand;
  late final Command<void, void> turnLeftCommand;
  late final Command<double, void> turnOffsetCommand;
  late final Command<double, void> rotateCommand;
  late final Command<void, void> playClipCommand;

  final ValueNotifier<double> elapsedFrames = ValueNotifier(0);
  final Map<String, AnimationClip> _animationMap = {};

  AnimatedSceneViewModel({required this.config}) {
    loadCommand = Command.createAsyncNoParamNoResult(_loadScene);

    playClipCommand = Command.createSyncNoResult<String>(
      (String clipName) => _play(clipName),
    );
  }

  void update(Duration elapsed) {
    elapsedFrames.value = elapsed.inMilliseconds / 1000 * config.fps;
  }

  Future<void> _loadScene() async {
    final node = await Node.fromAsset(config.modelAssetPath);

    for (final animation in node.parsedAnimations) {
      _animationMap[animation.name] = _createClip(node, animation.name);
    }

    var defaultClip = _animationMap[config.defaultAnimation.name];
    defaultClip
      ?..weight = 1
      ..play();

    scene.add(node);
    scene.environment
      ..exposure = config.environmentExposure
      ..intensity = config.environmentIntensity;
  }

  AnimationClip _createClip(Node node, String name) {
    var animation = node.findAnimationByName(name);
    if (animation == null) throw Exception('Animation $name not found.');
    return node.createAnimationClip(animation)
      ..loop = true
      ..weight = 0;
  }

  void _play(String clipName) {
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
  }

  @override
  void dispose() {
    scene.removeAll();
    elapsedFrames.dispose();
    super.dispose();
  }
}
