import 'dart:math';

import 'package:flutter/material.dart';

import 'package:unizen/ui/animated_scene/animated_scene.dart';
import 'package:unizen/ui/animated_scene/view_models/rotation_view_model.dart';

import '../../../domain/models/exam/exam.dart';
import '../widgets/add_exam_page.dart';
import '../widgets/exam_page.dart';

class HomePageViewModel extends ChangeNotifier {
  final List<Exam> exams;
  late List<RotationViewModel> rotationViewModels;
  late TurnOffset turnOffset;
  bool sceneReady = false;

  HomePageViewModel({required this.exams, this.turnOffset = TurnOffset.turn60});

  void init(PageController pageController) {
    AnimatedSceneWidget.initialize().then((_) {
      rotationViewModels = exams.map((_) => RotationViewModel()).toList();
      sceneReady = true;
      notifyListeners();
    });

    pageController.addListener(() {
      final page = pageController.page ?? 0.0;
      final intPart = page.floor();
      final decimalPart = page - intPart;

      if (decimalPart != 0 && intPart > 0 && intPart < exams.length) {
        var lIndex = intPart - 1;
        var rIndex = intPart;

        rotationViewModels
            .elementAt(lIndex)
            .rotateCommand
            .execute(decimalPart * turnOffset.radians);

        rotationViewModels
            .elementAt(rIndex)
            .rotateCommand
            .execute(-(1 - decimalPart) * turnOffset.radians);
      }
    });
  }

  int get pageCount => exams.length + 1;

  List<Widget> buildPages() {
    return [
      AddExamPage(rVerticalText: exams.firstOrNull?.name ?? ''),
      ...exams.asMap().entries.map((entry) {
        final index = entry.key;
        final exam = entry.value;

        final lVerticalText = switch (index) {
          0 => 'NEW EXAM',
          _ => exams.elementAt(index - 1).name,
        };

        var rVerticalText = '';
        if (index + 1 < exams.length) {
          rVerticalText = exams.elementAt(index + 1).name;
        }

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

enum TurnOffset {
  turn45(pi / 4),
  turn60(pi / 3),
  turn90(pi / 2);

  const TurnOffset(this.radians);

  final num radians;
}
