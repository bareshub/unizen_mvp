import 'package:flutter/material.dart';
import 'package:unizen/ui/core/ui/frosted_glass_box.dart';
import 'package:unizen/ui/health_bar/widgets/health_bar_style.dart';

class HealthBarFill extends StatelessWidget {
  const HealthBarFill({
    super.key,
    required this.healthPercentage,
    required this.child,
  });

  final double healthPercentage;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: healthPercentage.clamp(0.0, 1.0),
      child: FrostedGlassBox(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            color: HealthBarStyle.backgroundColor(
              healthPercentage,
            ).withAlpha((0.7 * 255).toInt()),
            border: Border.all(
              color: HealthBarStyle.borderColor(
                healthPercentage,
              ).withAlpha((0.9 * 255).toInt()),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: child,
        ),
      ),
    );
  }
}
