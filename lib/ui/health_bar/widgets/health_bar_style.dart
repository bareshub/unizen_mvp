import 'dart:ui' show Color;

import 'package:unizen/ui/core/themes/colors.dart';

class HealthBarStyle {
  static const _fullHealthColor = AppColors.green1;
  static const _mediumHealthColor = AppColors.orange1;
  static const _lowHealthColor = AppColors.red1;

  static Color backgroundColor(double percentage) {
    return _lerpColor(percentage).withAlpha(152);
  }

  static Color borderColor(double percentage) {
    return _lerpColor(percentage).withAlpha(192);
  }

  static Color _lerpColor(double percentage) {
    if (percentage >= 0.7) {
      return _fullHealthColor;
    } else if (percentage >= 0.3) {
      return _mediumHealthColor;
    } else {
      return _lowHealthColor;
    }
  }
}
