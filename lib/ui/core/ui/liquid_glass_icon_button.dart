import 'package:flutter/material.dart';
import 'package:unizen/ui/core/ui/liquid_glass_box.dart';

class LiquidGlassIconButton extends StatelessWidget {
  const LiquidGlassIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 24.0,
  });

  final IconData icon;
  final Function()? onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: LiquidGlassBox(
        radius: size / 2,
        child: IconButton(
          onPressed: onPressed,
          style: IconButton.styleFrom(
            highlightColor: Theme.of(
              context,
            ).colorScheme.onPrimary.withAlpha(64),
            padding: EdgeInsets.all(0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          icon: Icon(
            icon,
            color: Theme.of(context).colorScheme.onPrimary,
            size: size,
          ),
        ),
      ),
    );
  }
}
