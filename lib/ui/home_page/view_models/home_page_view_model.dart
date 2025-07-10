import 'dart:math';
import 'package:flutter/material.dart';
import 'package:unizen/ui/animated_scene/animated_scene.dart';
import 'package:unizen/ui/animated_scene/view_models/rotation_view_model.dart';

import '../models/exam.dart';
import '../widgets/add_exam_page.dart';
import '../widgets/exam_page.dart';

class HomePageViewModel extends ChangeNotifier {
  final List<Exam> exams;
  late List<RotationViewModel> rotationViewModels;
  bool sceneReady = false;

  HomePageViewModel({required this.exams});

  void init(PageController pageController) {
    AnimatedScene.initialize().then((_) {
      rotationViewModels = exams.map((_) => RotationViewModel()).toList();
      sceneReady = true;
      notifyListeners();
    });

    pageController.addListener(() {
      final page = pageController.page ?? 0.0;
      final intPart = page.floor();
      final decimalPart = page - intPart;

      if (decimalPart != 0 && exams.elementAtOrNull(intPart) != null) {
        var lIndex = intPart - 1;
        var rIndex = intPart;
        rotationViewModels
            .elementAt(lIndex)
            .rotateCommand
            .execute(decimalPart * pi / 3);
        rotationViewModels
            .elementAt(rIndex)
            .rotateCommand
            .execute(-(1 - decimalPart) * pi / 3);
      }
    });
  }

  int get pageCount => exams.length + 1;

  List<Widget> buildPages() {
    return [
      AddExamPage(),
      ...exams.asMap().entries.map((entry) {
        final index = entry.key;
        final exam = entry.value;
        final lVerticalText =
            index == 0 ? 'NEW EXAM' : exams.elementAt(index - 1).name;
        final rVerticalText =
            index == exams.length - 1 ? '' : exams.elementAt(index + 1).name;
        return ExamPage(
          rotationViewModel: rotationViewModels[index],
          exam: exam,
          lVerticalText: lVerticalText,
          rVerticalText: rVerticalText,
        );
      }),
    ];
  }

  @override
  void dispose() {
    for (var vm in rotationViewModels) {
      vm.dispose();
    }
    super.dispose();
  }
}
