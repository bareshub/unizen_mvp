class SceneConfig {
  final String modelAssetPath;
  final double turnOffset; // TODO create an enum instead of using a double
  final List<String> animationNames;
  final double environmentIntensity;
  final double environmentExposure;
  final double cameraDistance;
  final double fps;

  const SceneConfig({
    required this.modelAssetPath,
    this.turnOffset = 0.5,
    this.environmentIntensity = 1.0,
    this.environmentExposure = 4.0,
    this.animationNames = const ['idle'],
    this.cameraDistance = 10.0,
    this.fps = 60.0,
  });
}
