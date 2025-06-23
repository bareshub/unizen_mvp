import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class StudyTimerHeading extends StatelessWidget {
  const StudyTimerHeading({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      title,
      stepGranularity: 4.0,
      style: Theme.of(context).textTheme.headlineMedium,
      minFontSize: 16.0,
      overflow: TextOverflow.ellipsis,
    );
  }
}
