class HealthBar {
  final HealthBarSize size;

  const HealthBar({this.size = HealthBarSize.medium});
}

enum HealthBarSize {
  small(height: 16.0),
  medium(height: 20.0),
  large(height: 24.0);

  const HealthBarSize({required this.height});

  final double height;
}
