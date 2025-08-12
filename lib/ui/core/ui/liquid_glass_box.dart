import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class LiquidGlassBox extends StatelessWidget {
  const LiquidGlassBox({
    super.key,
    required this.child,
    this.alpha = 96,
    this.radius = 32.0,
    this.refractiveIndex = 1,
    this.color,
    this.liquidGlassSettings,
  });

  final Widget child;
  final int alpha;
  final double radius;
  final Color? color;
  final LiquidGlassSettings? liquidGlassSettings;
  final double refractiveIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: (color ?? Theme.of(context).colorScheme.primaryContainer)
                  .withAlpha(alpha),
            ),
          ),
          LiquidGlass(
            shape: LiquidRoundedSuperellipse(
              borderRadius: Radius.circular(radius),
            ),
            settings:
                liquidGlassSettings ??
                LiquidGlassSettings(
                  thickness: 20,
                  blur: 12.0,
                  refractiveIndex: refractiveIndex,
                  saturation: 1.5,
                ),
            child: Container(),
          ),
          child,
        ],
      ),
    );
  }
}
