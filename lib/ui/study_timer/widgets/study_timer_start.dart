import 'package:flutter/material.dart';

class StudyTimerStart extends StatelessWidget {
  const StudyTimerStart({super.key, required this.onStart});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        shadowColor: Theme.of(context).colorScheme.shadow.withAlpha(32),
        elevation: 2,
        minimumSize: Size(double.infinity, 56.0),
        overlayColor: Theme.of(context).colorScheme.onPrimary,
      ),
      onPressed: onStart,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.play_arrow_rounded, size: 24.0),
          SizedBox(width: 4.0),
          Text(
            'Start',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
