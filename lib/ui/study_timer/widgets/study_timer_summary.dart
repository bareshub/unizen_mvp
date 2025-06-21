import 'package:flutter/material.dart';

class StudyTimerSummary extends StatelessWidget {
  const StudyTimerSummary({super.key, this.hours = 0, this.minutes = 0});

  final int hours;
  final int minutes;

  @override
  Widget build(BuildContext context) {
    return Text(
      'total studied: ${hours}h ${minutes}m',
      style: Theme.of(context).textTheme.labelSmall,
    );
  }
}
