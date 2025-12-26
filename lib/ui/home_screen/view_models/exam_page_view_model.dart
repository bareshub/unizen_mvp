import 'package:flutter/material.dart';
import 'package:unizen/ui/study_timer/study_timer.dart';

import '../../../domain/models/exam/exam_page.dart';
import '../../../domain/models/health_bar/health_bar.dart';

class ExamPageViewModel extends ChangeNotifier {
  static const spaceBetweenAnimatedSceneAndHealthBar = 8.0;
  static const spaceBetweenHealthBarAndStudyTimer = 24.0;
  static const horizontalMarginHealthBar = 96.0;
  static const horizontalMarginStudyTimer = 72.0;

  ExamPageViewModel({required this.model});

  final ExamPage model;

  bool get hasLeftVerticalText => (model.lVerticalText ?? '').isNotEmpty;
  bool get hasRightVerticalText => (model.rVerticalText ?? '').isNotEmpty;

  double calculateAnimatedSceneHeight(double maxHeight, StudyTimerState state) {
    final scale = switch (state) {
      StudyTimerState.finished => 0.5,
      StudyTimerState.studying => 0.5,
      _ => 0.4,
    };
    return maxHeight * scale -
        HealthBarSize.medium.height -
        spaceBetweenAnimatedSceneAndHealthBar -
        spaceBetweenHealthBarAndStudyTimer;
  }
}
