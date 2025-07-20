import '../../../domain/models/exam/exam.dart';
import '../../../domain/models/health_bar/health_bar.dart';

class ExamPageViewModel {
  final Exam exam;
  final String? lVerticalText;
  final String? rVerticalText;

  static const spaceBetweenAnimatedSceneAndHealthBar = 8.0;
  static const spaceBetweenHealthBarAndStudyTimer = 24.0;
  static const horizontalMarginHealthBar = 96.0;
  static const horizontalMarginStudyTimer = 72.0;

  ExamPageViewModel({
    required this.exam,
    this.lVerticalText,
    this.rVerticalText,
  });

  double calculateAnimatedSceneHeight(double maxHeight) {
    return maxHeight / 2 -
        HealthBarSize.medium.height -
        spaceBetweenAnimatedSceneAndHealthBar -
        spaceBetweenHealthBarAndStudyTimer;
  }

  bool get hasLeftVerticalText => (lVerticalText ?? '').isNotEmpty;
  bool get hasRightVerticalText => (rVerticalText ?? '').isNotEmpty;
}
