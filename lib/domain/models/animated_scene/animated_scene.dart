class AnimatedScene {
  final String modelAssetPath;
  final Animation defaultAnimation;
  final double environmentIntensity;
  final double environmentExposure;
  final double cameraDistance;
  final double fps;

  const AnimatedScene({
    required this.modelAssetPath,
    this.defaultAnimation = Animation.idle,
    this.environmentIntensity = 3.0,
    this.environmentExposure = 4.0,
    this.cameraDistance = 10.0,
    this.fps = 60.0,
  });
}

enum Animation { idle, walk, attack, death }
