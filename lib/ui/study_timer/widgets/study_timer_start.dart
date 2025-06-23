import 'package:flutter/material.dart';
import 'package:unizen/ui/core/ui/frosted_glass_text_button.dart';

class StudyTimerStart extends StatelessWidget {
  const StudyTimerStart({super.key, required this.onStart});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return FrostedGlassTextButton(
      text: 'Start',
      action: onStart,
      icon: Icons.play_arrow_rounded,
    );
  }
}
