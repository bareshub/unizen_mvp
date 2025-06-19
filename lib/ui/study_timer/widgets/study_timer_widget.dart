import 'dart:math';

import 'package:flutter/material.dart';
import 'package:unizen/ui/core/ui/frosted_glass_box.dart';

class StudyTimer extends StatelessWidget {
  const StudyTimer({super.key, required this.examName, this.margin});

  final String examName;
  final EdgeInsetsGeometry? margin;

  final minSize = 240.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var size = min(
          constraints.maxWidth - (margin?.horizontal ?? 0),
          constraints.maxHeight - (margin?.vertical ?? 0),
        );

        size = max(size, minSize);

        return SizedBox(
          width: size,
          height: size,
          child: FrostedGlassBox(
            child: Column(
              children: [
                // Exam title
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(48.0, 24.0, 48.0, 0.0),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.center,
                    child: Text(
                      examName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        height: 1,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
                // Exam summary
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 48.0),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.center,
                    child: Text('3h e 25 minuti studiati'),
                  ),
                ),
                // - Timer +
                // Start button
              ],
            ),
          ),
        );
      },
    );
  }
}
