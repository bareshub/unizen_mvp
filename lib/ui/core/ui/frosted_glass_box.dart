import 'dart:ui';

import 'package:flutter/material.dart';

class FrostedGlassBox extends StatelessWidget {
  const FrostedGlassBox({
    super.key,
    required this.child,
    this.borderRadius = 32.0,
    this.blurSigma = 8.0,
    this.width = double.infinity,
    this.height = double.infinity,
    this.margin,
  });

  final Widget child;
  final double borderRadius;
  final double blurSigma;
  final double width;
  final double height;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  topRight: Radius.circular(borderRadius - 3),
                  bottomRight: Radius.circular(borderRadius),
                  bottomLeft: Radius.circular(borderRadius - 3),
                ),
                border: Border.all(color: Colors.white24, width: 1.5),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
