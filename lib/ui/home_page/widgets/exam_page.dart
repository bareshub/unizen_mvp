import 'package:flutter/material.dart';

import 'package:unizen/ui/animated_scene/animated_scene.dart';
import 'package:unizen/ui/animated_scene/view_models/rotation_view_model.dart';
import 'package:unizen/ui/core/ui/vertical_text.dart';
import 'package:unizen/ui/health_bar/health_bar.dart';
import 'package:unizen/ui/home_page/view_models/exam_page_view_model.dart';
import 'package:unizen/ui/study_timer/study_timer.dart';
import 'package:unizen/ui/core/ui/overlay_text.dart';

import '../models/exam.dart';

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
          child: AnimatedScene(
            sceneConfig: exam.sceneConfig,
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
    return HealthBar(
      viewModel: HealthBarViewModel(
        config: HealthBarConfig(size: HealthBarSize.medium),
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
    return StudyTimer(
      viewModel: StudyTimerViewModel(config: StudyTimerConfig()),
      examName: exam.name,
      margin: margin,
    );
  }
}
