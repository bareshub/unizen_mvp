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
  late final Command<void, void> playClipCommand;

  final ValueNotifier<double> elapsedFrames = ValueNotifier(0);
  final ValueNotifier<double> rotationX = ValueNotifier(0);

  double _destinationX = 0;

  Map<String, AnimationClip> animationMap = {};

  AnimatedSceneViewModel({required this.config}) {
    loadCommand = Command.createAsyncNoParamNoResult(_loadScene);

    turnRightCommand = Command.createSyncNoParamNoResult(_turnRight);
    turnLeftCommand = Command.createSyncNoParamNoResult(_turnLeft);

    playClipCommand = Command.createSyncNoResult<String>(
      (String clipName) => _play(clipName),
    );
  }

  void update(Duration elapsed) {
    elapsedFrames.value = elapsed.inMilliseconds / 1000 * config.fps;
    final current = rotationX.value;
    final step = config.turnOffset.radians / config.fps * 10;

    if (_destinationX > 0 && current < _destinationX) {
      rotationX.value = (current + step).clamp(
        -config.turnOffset.radians.toDouble(),
        _destinationX,
      );
    } else if (_destinationX < 0 && current > _destinationX) {
      rotationX.value = (current - step).clamp(
        _destinationX,
        config.turnOffset.radians.toDouble(),
      );
    }
  }

  Future<void> _loadScene() async {
    final node = await Node.fromAsset(config.modelAssetPath);

    for (final animation in node.parsedAnimations) {
      animationMap[animation.name] = _createClip(node, animation.name);
    }

    var defaultClip = animationMap[config.defaultAnimation.name];
    defaultClip
      ?..weight = 1
      ..play();

    scene.add(node);
    scene.environment
      ..exposure = config.environmentExposure
      ..intensity = config.environmentIntensity;

    await Scene.initializeStaticResources();
  }

  AnimationClip _createClip(Node node, String name) {
    var animation = node.findAnimationByName(name);
    if (animation == null) throw Exception('Animation $name not found.');
    return node.createAnimationClip(animation)
      ..loop = true
      ..weight = 0;
  }

  void _turnRight() => _destinationX = config.turnOffset.radians.toDouble();

  void _turnLeft() => _destinationX = -config.turnOffset.radians.toDouble();

  void _play(String clipName) {
    animationMap.forEach((key, clip) {
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
    rotationX.dispose();
    super.dispose();
  }
}
