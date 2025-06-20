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
            child: Center(
              child: Column(
                children: [
                  // Exam title
                  Padding(
                    padding: const EdgeInsetsGeometry.only(top: 24.0),
                    child: Text(
                      examName,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),

                  // Exam summary
                  Text(
                    'Total studied: 3h 45m',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),

                  Spacer(),

                  // - Timer +
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white38,
                            shadowColor: Theme.of(
                              context,
                            ).colorScheme.shadow.withAlpha(32),
                            elevation: 2,
                            padding: EdgeInsets.all(0),
                            minimumSize: Size.fromRadius(16.0),
                          ),
                          onPressed: () {},
                          icon: Icon(
                            Icons.remove,
                            size: 24.0,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              '25',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ),
                        ),
                        SizedBox(width: 4.0),
                        Text(
                          'min',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        SizedBox(width: 8.0),
                        IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white38,
                            shadowColor: Theme.of(
                              context,
                            ).colorScheme.shadow.withAlpha(32),
                            elevation: 2,
                            padding: EdgeInsets.all(0),
                            minimumSize: Size.fromRadius(16.0),
                          ),
                          onPressed: () {},
                          icon: Icon(
                            Icons.add,
                            size: 24.0,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Spacer(),

                  // Start button
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        ),
                        shadowColor: Theme.of(
                          context,
                        ).colorScheme.shadow.withAlpha(32),
                        elevation: 2,
                        minimumSize: Size(double.infinity, 56.0),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.play_arrow_rounded, size: 24.0),
                          SizedBox(width: 4.0),
                          Text(
                            'Start Session',
                            style: Theme.of(
                              context,
                            ).textTheme.labelLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
