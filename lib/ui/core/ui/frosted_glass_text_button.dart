import 'package:flutter/material.dart';

class FrostedGlassTextButton extends StatelessWidget {
  const FrostedGlassTextButton({
    super.key,
    required this.text,
    this.action,
    this.foregroundColor,
    this.backgroundColor,
    this.overlayColor,
    this.icon,
  });

  final String text;
  final VoidCallback? action;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? overlayColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor:
            foregroundColor ?? Theme.of(context).colorScheme.onSecondary,
        backgroundColor:
            backgroundColor ?? Theme.of(context).colorScheme.secondary,
        shadowColor: Theme.of(context).colorScheme.shadow.withAlpha(32),
        overlayColor: overlayColor ?? Theme.of(context).colorScheme.onSecondary,
        elevation: 2,
        textStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: Theme.of(context).colorScheme.secondary,
        ),
        minimumSize: Size.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: action,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Icon(icon, size: 16.0),
            ),
          Text(text, style: TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
