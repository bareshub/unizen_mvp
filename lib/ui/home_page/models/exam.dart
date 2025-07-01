class Exam {
  const Exam({
    required this.name,
    required this.modelAssetPath,
    required this.maxHealth,
    required this.health,
    this.environmentIntensity = 3.0,
    this.cameraDistance = 10.0,
  });

  final String name;
  final String modelAssetPath;
  final int maxHealth;
  final int health;
  final double environmentIntensity;
  final double cameraDistance;
}
