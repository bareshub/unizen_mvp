import 'package:flutter/material.dart';

class CustomInkWell extends StatelessWidget {
  const CustomInkWell({
    super.key,
    required this.child,
    required this.onTap,
    this.borderRadius = 60.0,
  });

  final Widget child;
  final VoidCallback onTap;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.white38,
      highlightColor: Colors.transparent,
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: onTap,
      child: child,
    );
  }
}
