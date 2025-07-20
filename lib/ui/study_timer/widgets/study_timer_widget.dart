import 'dart:math';

import 'package:flutter/material.dart';

import '../../../ui/core/ui/frosted_glass_box.dart';
import '../view_models/study_timer_view_model.dart';
import 'study_timer_controls.dart';
import 'study_timer_heading.dart';
import 'study_timer_start.dart';
import 'study_timer_summary.dart';
import 'study_timer_edit.dart';

class StudyTimerWidget extends StatelessWidget {
  const StudyTimerWidget({
    super.key,
    required this.viewModel,
    required this.examName,
    this.minSize = 240.0,
    this.margin,
  });

  final StudyTimerViewModel viewModel;
  final String examName;
  final double minSize;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: viewModel.minutes,
      builder:
          (context, minutes, _) => LayoutBuilder(
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
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        StudyTimerHeading(title: examName),
                        StudyTimerSummary(hours: 3, minutes: 45),
                        Spacer(),
                        StudyTimerControls(
                          minutes: minutes,
                          onPlusClick:
                              viewModel.incrementable
                                  ? () =>
                                      viewModel.incrementTimerCommand.execute()
                                  : null,
                          onMinusClick:
                              viewModel.decrementable
                                  ? () =>
                                      viewModel.decrementTimerCommand.execute()
                                  : null,
                        ),
                        Spacer(),
                        StudyTimerEdit(onEdit: () {}),
                        SizedBox(height: 8.0),
                        StudyTimerStart(onStart: () {}),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
    );
  }
}
