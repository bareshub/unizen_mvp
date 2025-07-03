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
    this.turnOffset = TurnOffset.turn30,
    this.environmentIntensity = 3.0,
    this.environmentExposure = 4.0,
    this.cameraDistance = 10.0,
    this.fps = 60.0,
  });
}

enum Animation { idle, walk, attack, death }

enum TurnOffset {
  turn15(pi / 24),
  turn30(pi / 12),
  turn45(pi / 8);

  const TurnOffset(this.radians);

  final num radians;
}
