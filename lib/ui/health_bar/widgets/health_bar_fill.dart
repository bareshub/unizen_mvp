import 'dart:math';

import 'package:flutter/material.dart';
import 'package:unizen/ui/core/ui/frosted_glass_box.dart';

import './health_bar_style.dart';

class HealthBarFill extends StatelessWidget {
  const HealthBarFill({
    super.key,
    required this.health,
    required this.maxHealth,
    required this.child,
  });

  final int health;
  final int maxHealth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FrostedGlassBox(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final healthPercentage = (maxHealth <= 0) ? 0.0 : health / maxHealth;

          final minWidth = calculateMinWidth(
            healthPercentage,
            constraints.maxWidth,
          );

          return UnconstrainedBox(
            constrainedAxis: Axis.vertical,
            child: AnimatedContainer(
              constraints: BoxConstraints(minWidth: minWidth),
              duration: Durations.extralong4,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                color: HealthBarStyle.backgroundColor(healthPercentage),
                border: Border.all(
                  color: HealthBarStyle.borderColor(healthPercentage),
                  width: 1.5,
                ),
              ),
              child: child,
            ),
          );
        },
      ),
    );
  }

  double calculateMinWidth(double healthPercentage, double maxWidth) =>
      switch (health) {
        >= 1000 => max(healthPercentage * maxWidth, 50.0),
        >= 100 => 45.0,
        >= 10 => 40.0,
        _ => 35.0,
      };
}
