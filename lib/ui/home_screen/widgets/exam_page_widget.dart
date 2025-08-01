import 'package:flutter/material.dart';

import '../../../domain/models/exam/exam.dart';
import '../../../domain/models/health_bar/health_bar.dart';
import '../../../domain/models/study_timer/study_timer.dart';
import '../../animated_scene/animated_scene.dart';
import '../../core/ui/overlay_text.dart';
import '../../core/ui/vertical_text.dart';
import '../../health_bar/health_bar.dart';
import '../../study_timer/study_timer.dart';
import '../view_models/exam_page_view_model.dart';

class ExamPageWidget extends StatelessWidget {
  const ExamPageWidget({super.key, required this.viewModel});

  final ExamPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final animatedSceneHeight = viewModel.calculateAnimatedSceneHeight(
          constraints.maxHeight,
        );

        return Stack(
          children: [
            if (viewModel.hasLeftVerticalText)
              VerticalText(
                text: viewModel.model.lVerticalText!,
                alignment: Alignment.centerLeft,
              ),
            SingleChildScrollView(
              child: Column(
                children: [
                  _AnimatedSceneSection(
                    exam: viewModel.model.exam,
                    height: animatedSceneHeight,
                  ),
                  const SizedBox(
                    height:
                        ExamPageViewModel.spaceBetweenAnimatedSceneAndHealthBar,
                  ),
                  _HealthBarSection(
                    exam: viewModel.model.exam,
                    margin: EdgeInsets.symmetric(
                      horizontal: ExamPageViewModel.horizontalMarginHealthBar,
                    ),
                  ),
                  const SizedBox(
                    height:
                        ExamPageViewModel.spaceBetweenHealthBarAndStudyTimer,
                  ),
                  StudyTimerWidget(
                    viewModel: StudyTimerViewModel(config: StudyTimer()),
                    examName: viewModel.model.exam.name,
                    margin: EdgeInsets.all(
                      ExamPageViewModel.horizontalMarginStudyTimer,
                    ),
                  ),
                ],
              ),
            ),
            if (viewModel.hasRightVerticalText)
              VerticalText(
                text: viewModel.model.rVerticalText!,
                alignment: Alignment.centerRight,
              ),
          ],
        );
      },
    );
  }
}

class _AnimatedSceneSection extends StatelessWidget {
  const _AnimatedSceneSection({required this.exam, required this.height});

  final Exam exam;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        OverlayText(
          exam.name,
          margin: const EdgeInsets.symmetric(horizontal: 96.0, vertical: 8.0),
        ),
        SizedBox(
          height: height,
          width: double.infinity,
          child: AnimatedSceneWidget(exam: exam),
        ),
      ],
    );
  }
}

class _HealthBarSection extends StatelessWidget {
  const _HealthBarSection({required this.exam, this.margin});

  final Exam exam;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return HealthBarWidget(
      viewModel: HealthBarViewModel(
        config: HealthBar(size: HealthBarSize.medium),
        maxHealth: exam.maxHealth,
        health: exam.health,
      ),
      margin: margin,
    );
  }
}
