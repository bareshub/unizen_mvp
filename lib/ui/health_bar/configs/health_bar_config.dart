class HealthBarConfig {
  final HealthBarSize size;

  const HealthBarConfig({this.size = HealthBarSize.medium});
}

enum HealthBarSize {
  small(height: 16.0),
  medium(height: 20.0),
  large(height: 24.0);

  const HealthBarSize({required this.height});

  final double height;
}
