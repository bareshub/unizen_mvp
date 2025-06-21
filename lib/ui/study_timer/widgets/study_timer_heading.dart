import 'package:flutter/material.dart';

class StudyTimerHeading extends StatelessWidget {
  const StudyTimerHeading({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 40.0),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
