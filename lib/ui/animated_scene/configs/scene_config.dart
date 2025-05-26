import 'dart:math';

class SceneConfig {
  final String modelAssetPath;
  final Animation defaultAnimation;
  final TurnOffset turnOffset;
  final double environmentIntensity;
  final double environmentExposure;
  final double cameraDistance;
  final double fps;

  const SceneConfig({
    required this.modelAssetPath,
    this.defaultAnimation = Animation.idle,
    this.turnOffset = TurnOffset.turn45,
    this.environmentIntensity = 1.0,
    this.environmentExposure = 4.0,
    this.cameraDistance = 10.0,
    this.fps = 60.0,
  });
}

enum Animation { idle, walk, attack, death }

enum TurnOffset {
  turn45(pi / 4),
  turn90(pi / 2),
  turn180(pi);

  const TurnOffset(this.radians);

  final num radians;
}
