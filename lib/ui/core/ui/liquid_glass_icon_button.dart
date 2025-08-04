import 'package:flutter/material.dart';
import 'package:unizen/ui/core/ui/liquid_glass_box.dart';

class LiquidGlassIconButton extends StatelessWidget {
  const LiquidGlassIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.size = 24.0,
  });

  final Function()? onPressed;
  final IconData icon;
  final double size;

  bool get _disabled => onPressed == null;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: LiquidGlassBox(
        color: _disabled ? Theme.of(context).colorScheme.shadow : null,
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
            color:
                _disabled
                    ? Theme.of(context).colorScheme.onPrimary.withAlpha(64)
                    : Theme.of(context).colorScheme.onPrimary,
            size: size,
          ),
        ),
      ),
    );
  }
}
