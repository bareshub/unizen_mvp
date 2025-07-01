import 'package:flutter/material.dart';

import 'package:unizen/ui/animated_scene/animated_scene.dart';
import 'package:unizen/ui/core/ui/vertical_text.dart';
import 'package:unizen/ui/health_bar/health_bar.dart';
import 'package:unizen/ui/study_timer/study_timer.dart';
import 'package:unizen/ui/core/ui/overlay_text.dart';

import '../models/exam.dart';

class ExamPage extends StatelessWidget {
  const ExamPage({
    super.key,
    required this.animatedSceneViewModel,
    required this.exam,
    this.lVerticalText,
    this.rVerticalText,
  });

  final AnimatedSceneViewModel animatedSceneViewModel;

  final Exam exam;
  final String? lVerticalText;
  final String? rVerticalText;

  static const _spaceBetweenAnimatedSceneAndHealthBar = 8.0;
  static const _spaceBetweenHealthBarAndStudyTimer = 24.0;
  static const _horizontalMarginHealthBar = 96.0;
  static const _horizontalMarginStudyTimer = 72.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final animatedSceneHeight =
              constraints.maxHeight / 2 -
              HealthBarSize.medium.height -
              _spaceBetweenAnimatedSceneAndHealthBar -
              _spaceBetweenHealthBarAndStudyTimer;

          return Stack(
            children: [
              if ((lVerticalText ?? '').isNotEmpty)
                VerticalText(
                  text: lVerticalText!,
                  alignment: Alignment.centerLeft,
                ),
              Column(
                children: [
                  _AnimatedSceneSection(
                    viewModel: animatedSceneViewModel,
                    exam: exam,
                    height: animatedSceneHeight,
                  ),
                  const SizedBox(
                    height: _spaceBetweenAnimatedSceneAndHealthBar,
                  ),
                  _HealthBarSection(
                    exam: exam,
                    margin: EdgeInsets.symmetric(
                      horizontal: _horizontalMarginHealthBar,
                    ),
                  ),
                  const SizedBox(height: _spaceBetweenHealthBarAndStudyTimer),
                  _StudyTimerSection(
                    exam: exam,
                    margin: EdgeInsets.all(_horizontalMarginStudyTimer),
                  ),
                ],
              ),
              if ((rVerticalText ?? '').isNotEmpty)
                VerticalText(
                  text: rVerticalText!,
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
    required this.viewModel,
    required this.exam,
    required this.height,
  });

  final Exam exam;
  final double height;
  final AnimatedSceneViewModel viewModel;

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
          child: AnimatedScene(viewModel: viewModel),
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
