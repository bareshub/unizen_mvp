import 'package:flutter/material.dart';

import '../../../ui/core/ui/liquid_glass_box.dart';

class HealthBarBackground extends StatelessWidget {
  const HealthBarBackground({
    super.key,
    this.margin,
    required this.height,
    required this.child,
  });

  final double height;
  final EdgeInsetsGeometry? margin;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      margin: margin,
      child: LiquidGlassBox(child: child),
    );
  }
}
