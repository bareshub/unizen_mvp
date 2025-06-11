import 'dart:ui';

import 'package:flutter/material.dart';

class FrostedGlassBox extends StatelessWidget {
  const FrostedGlassBox({
    super.key,
    required this.child,
    this.borderRadius = 24.0,
    this.blurSigma = 8.0,
    this.width,
    this.height,
    this.margin,
  });

  final Widget child;
  final double borderRadius;
  final double blurSigma;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(borderRadius),
      child: Container(
        width: width,
        height: height,
        margin: margin,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                color: Colors.white24,
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: blurSigma,
                sigmaY: blurSigma,
                tileMode: TileMode.decal,
              ),
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
