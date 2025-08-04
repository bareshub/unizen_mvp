class StaticScene {
  const StaticScene({
    required this.modelAssetPath,
    this.environmentIntensity = 3.0,
    this.environmentExposure = 3.0,
    this.cameraDistance = 10.0,
  });

  final String modelAssetPath;
  final double environmentIntensity;
  final double environmentExposure;
  final double cameraDistance;
}
