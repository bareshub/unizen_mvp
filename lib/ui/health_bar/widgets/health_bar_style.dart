import 'dart:ui' show Color;

class HealthBarStyle {
  // Health Bar Palette
  static const Color _healthHigh = Color(0xFF61A764);
  static const Color _healthModerate = Color(0xFFF9A825);
  static const Color _healthLow = Color(0xFFF57C00);
  static const Color _healthCritical = Color(0xFFF34D3E);

  static Color backgroundColor(double percentage) {
    return _lerpColor(percentage).withAlpha(152);
  }

  static Color borderColor(double percentage) {
    return _lerpColor(percentage).withAlpha(192);
  }

  static Color _lerpColor(double percentage) => switch (percentage) {
    >= 0.7 => _healthHigh,
    >= 0.5 => _healthModerate,
    >= 0.3 => _healthLow,
    _ => _healthCritical,
  };
}
