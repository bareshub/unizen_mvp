import 'package:flutter/material.dart';
import 'package:unizen/ui/core/ui/frosted_glass_box.dart';

class HealthBarFill extends StatelessWidget {
  const HealthBarFill({
    super.key,
    required this.widthFactor,
    required this.child,
  });

  final double widthFactor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: widthFactor.clamp(0.0, 1.0),
      child: FrostedGlassBox(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            color: Colors.deepOrange.withAlpha(
              192,
            ), // todo update based on health
            border: Border.all(
              color: Colors.deepOrange,
              width: 1.5,
            ), // todo update based on health
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: child,
        ),
      ),
    );
  }
}
