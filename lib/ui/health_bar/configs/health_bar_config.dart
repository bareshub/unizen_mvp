class HealthBarConfig {
  final int maxHealth;
  final HealthBarSize size;

  const HealthBarConfig({
    required this.maxHealth,
    this.size = HealthBarSize.medium,
  });
}

enum HealthBarSize { small, medium, large }
