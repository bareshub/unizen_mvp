import 'package:flutter/material.dart';

class StudyTimerSummary extends StatelessWidget {
  const StudyTimerSummary({super.key, this.hours = 0, this.minutes = 0});

  final int hours;
  final int minutes;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Total Studied: ', style: Theme.of(context).textTheme.labelSmall),
        Text(
          '${hours}h ${minutes}m',
          style: Theme.of(
            context,
          ).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
