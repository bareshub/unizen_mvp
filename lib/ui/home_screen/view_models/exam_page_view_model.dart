import 'package:flutter/material.dart';

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

  double calculateAnimatedSceneHeight(double maxHeight) {
    return maxHeight / 2 -
        HealthBarSize.medium.height -
        spaceBetweenAnimatedSceneAndHealthBar -
        spaceBetweenHealthBarAndStudyTimer;
  }
}
