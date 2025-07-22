import 'package:flutter/material.dart';

class FrostedGlassIconButton extends StatelessWidget {
  const FrostedGlassIconButton({
    super.key,
    required this.icon,
    this.size = 24.0,
    this.action,
  });

  final IconData icon;
  final double size;
  final VoidCallback? action;

  @override
  Widget build(BuildContext context) {
    final disabled = action == null;

    return IconButton(
      onPressed: action,
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        disabledBackgroundColor: Theme.of(
          context,
        ).colorScheme.primaryContainer.withAlpha(64),
        highlightColor: Theme.of(context).colorScheme.onPrimary.withAlpha(128),
        shadowColor: Theme.of(context).colorScheme.shadow.withAlpha(32),
        elevation: 2,
        minimumSize: Size.fromRadius(16.0),
        padding: EdgeInsets.all(0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      icon: Icon(
        icon,
        size: size,
        color: Theme.of(
          context,
        ).colorScheme.secondary.withAlpha(disabled ? 64 : 255),
      ),
    );
  }
}
