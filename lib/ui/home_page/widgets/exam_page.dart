import 'package:flutter/material.dart';

import '../../../domain/models/exam/exam.dart';
import '../../../domain/models/health_bar/health_bar.dart';
import '../../../domain/models/study_timer/study_timer.dart';
import '../../../ui/animated_scene/animated_scene.dart';
import '../../../ui/animated_scene/view_models/rotation_view_model.dart';
import '../../../ui/core/ui/overlay_text.dart';
import '../../../ui/core/ui/vertical_text.dart';
import '../../../ui/health_bar/health_bar.dart';
import '../../../ui/home_page/view_models/exam_page_view_model.dart';
import '../../../ui/study_timer/study_timer.dart';

class ExamPage extends StatelessWidget {
  const ExamPage({
    super.key,
    required this.rotationViewModel,
    required this.exam,
    this.lVerticalText,
    this.rVerticalText,
  });

  final RotationViewModel rotationViewModel;
  final Exam exam;
  final String? lVerticalText;
  final String? rVerticalText;

  @override
  Widget build(BuildContext context) {
    final viewModel = ExamPageViewModel(
      exam: exam,
      lVerticalText: lVerticalText,
      rVerticalText: rVerticalText,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final animatedSceneHeight = viewModel.calculateAnimatedSceneHeight(
            constraints.maxHeight,
          );

          return Stack(
            children: [
              if (viewModel.hasLeftVerticalText)
                VerticalText(
                  text: viewModel.lVerticalText!,
                  alignment: Alignment.centerLeft,
                ),
              Column(
                children: [
                  _AnimatedSceneSection(
                    rotationViewModel: rotationViewModel,
                    exam: exam,
                    height: animatedSceneHeight,
                  ),
                  const SizedBox(
                    height:
                        ExamPageViewModel.spaceBetweenAnimatedSceneAndHealthBar,
                  ),
                  _HealthBarSection(
                    exam: exam,
                    margin: EdgeInsets.symmetric(
                      horizontal: ExamPageViewModel.horizontalMarginHealthBar,
                    ),
                  ),
                  const SizedBox(
                    height:
                        ExamPageViewModel.spaceBetweenHealthBarAndStudyTimer,
                  ),
                  _StudyTimerSection(
                    exam: exam,
                    margin: EdgeInsets.all(
                      ExamPageViewModel.horizontalMarginStudyTimer,
                    ),
                  ),
                ],
              ),
              if (viewModel.hasRightVerticalText)
                VerticalText(
                  text: viewModel.rVerticalText!,
                  alignment: Alignment.centerRight,
                ),
            ],
          );
        },
      ),
    );
  }
}

class _AnimatedSceneSection extends StatelessWidget {
  const _AnimatedSceneSection({
    required this.rotationViewModel,
    required this.exam,
    required this.height,
  });

  final Exam exam;
  final double height;
  final RotationViewModel rotationViewModel;

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
          child: AnimatedSceneWidget(
            model: exam.animatedScene,
            rotationViewModel: rotationViewModel,
          ),
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

class _StudyTimerSection extends StatelessWidget {
  const _StudyTimerSection({required this.exam, this.margin});

  final Exam exam;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return StudyTimerWidget(
      viewModel: StudyTimerViewModel(config: StudyTimer()),
      examName: exam.name,
      margin: margin,
    );
  }
}
