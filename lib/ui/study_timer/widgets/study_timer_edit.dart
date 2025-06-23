import 'package:flutter/material.dart';
import 'package:unizen/ui/core/ui/frosted_glass_text_button.dart';

class StudyTimerEdit extends StatelessWidget {
  const StudyTimerEdit({super.key, required this.onEdit});

  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return FrostedGlassTextButton(
      text: 'Edit',
      action: onEdit,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      foregroundColor: Theme.of(context).colorScheme.secondary,
      icon: Icons.edit_rounded,
    );
  }
}
