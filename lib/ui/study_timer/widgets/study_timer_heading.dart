import 'package:flutter/material.dart';

class StudyTimerHeading extends StatelessWidget {
  const StudyTimerHeading({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall,
      overflow: TextOverflow.ellipsis,
    );
  }
}
