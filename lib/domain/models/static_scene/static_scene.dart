class StaticScene {
  const StaticScene({
    required this.modelAssetPath,
    this.environmentIntensity = 0.8,
    this.environmentExposure = 1.0,
    this.cameraDistance = 10.0,
  });

  final String modelAssetPath;
  final double environmentIntensity;
  final double environmentExposure;
  final double cameraDistance;
}
