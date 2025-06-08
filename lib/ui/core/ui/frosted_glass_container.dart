import 'dart:ui';

import 'package:flutter/material.dart';

class FrostedGlassContainer extends StatelessWidget {
  const FrostedGlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 8.0,
    this.blurSigma = 15.0,
  });

  final Widget child;
  final double borderRadius;
  final double blurSigma;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: child,
      ),
    );
  }
}
