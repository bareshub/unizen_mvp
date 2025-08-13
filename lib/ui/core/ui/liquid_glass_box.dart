import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class LiquidGlassBox extends StatelessWidget {
  const LiquidGlassBox({
    super.key,
    required this.child,
    this.alpha = 96,
    this.ambientStrength = 0.1,
    this.blur = 8.0,
    this.chromaticAberration = 0.1,
    this.lightness = 1.0,
    this.radius = 32.0,
    this.refractiveIndex = 1,
    this.saturation = 1.5,
    this.color,
    this.liquidGlassSettings,
  });

  final Widget child;
  final int alpha;
  final double ambientStrength;
  final double lightness;
  final double blur;
  final double chromaticAberration;
  final double radius;
  final double refractiveIndex;
  final double saturation;
  final Color? color;
  final LiquidGlassSettings? liquidGlassSettings;

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
                  blur: blur,
                  refractiveIndex: refractiveIndex,
                  saturation: saturation,
                  lightness: lightness,
                  chromaticAberration: chromaticAberration,
                  ambientStrength: ambientStrength,
                ),
            child: Container(),
          ),
          child,
        ],
      ),
    );
  }
}
