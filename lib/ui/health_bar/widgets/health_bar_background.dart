import 'package:flutter/material.dart';

import 'package:unizen/ui/core/ui/frosted_glass_box.dart';

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
    return FrostedGlassBox(
      width: double.infinity,
      height: height,
      margin: margin,
      child: Container(child: child),
    );
  }
}
