import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';

import '../../../data/repositories/exam/exam_repository.dart';
import '../../../ui/animated_scene/animated_scene.dart';
import '../../../ui/animated_scene/view_models/rotation_view_model.dart';
import '../../../utils/result.dart';

import '../../../domain/models/exam/exam.dart';
import '../widgets/add_exam_page.dart';
import '../widgets/exam_page.dart';

class HomePageViewModel extends ChangeNotifier {
  final ExamRepository _examRepository;
  final TurnOffset turnOffset;

  late final ValueNotifier<int> pageCount;
  late final Command<void, void> loadCommand;
  late final Command<PageController, void> initCommand;

  late List<RotationViewModel> rotationViewModels;

  List<Exam> _exams = [];
  bool sceneReady = false;

  HomePageViewModel({
    required ExamRepository examRepository,
    this.turnOffset = TurnOffset.turn60,
  }) : _examRepository = examRepository {
    pageCount = ValueNotifier(0);
    loadCommand = Command.createAsyncNoParamNoResult(_load);
    initCommand = Command.createSyncNoResult<PageController>(_init);
  }

  Future<void> _load() async {
    try {
      final result = await _examRepository.getExamsList();

      switch (result) {
        case Ok<List<Exam>>():
          _exams = result.value;
          break;
        case Error<Exam>():
          // TODO log warning / error
          break;
        default:
      }
    } finally {
      _updatePageCount();
      _loadAnimatedScene();
      notifyListeners();
    }
  }

  void _updatePageCount() {
    pageCount.value = _exams.length + 1;
    notifyListeners();
  }

  void _loadAnimatedScene() {
    AnimatedSceneWidget.initialize().then((_) {
      rotationViewModels = _exams.map((_) => RotationViewModel()).toList();
      sceneReady = true;
      notifyListeners();
    });
  }

  void _init(PageController pageController) {
    pageController.addListener(() {
      final page = pageController.page ?? 0.0;
      final intPart = page.floor();
      final decimalPart = page - intPart;

      if (decimalPart != 0 && intPart > 0 && intPart < _exams.length) {
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

  List<Widget> buildPages() {
    final examPages = _exams.asMap().entries.map((entry) {
      final index = entry.key;
      final exam = entry.value;

      final lVerticalText = switch (index) {
        0 => 'NEW EXAM',
        _ => _exams.elementAt(index - 1).name,
      };

      var rVerticalText = '';
      if (index + 1 < _exams.length) {
        rVerticalText = _exams.elementAt(index + 1).name;
      }

      return ExamPage(
        rotationViewModel: rotationViewModels[index],
        exam: exam,
        lVerticalText: lVerticalText,
        rVerticalText: rVerticalText,
      );
    });
    return [
      AddExamPage(rVerticalText: _exams.firstOrNull?.name ?? ''),
      ...examPages,
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
