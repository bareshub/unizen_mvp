import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';

import '../../../data/repositories/exam/exam_repository.dart';
import '../../../domain/models/exam/exam.dart';
import '../../../domain/models/exam/exam_page.dart';
import '../../../utils/result.dart';

enum HomeScreenState { initial, loading, loaded, error }

class HomeScreenViewModel extends ChangeNotifier {
  HomeScreenViewModel({
    required ExamRepository examRepository,
    this.turnOffset = TurnOffset.turn60,
  }) : _examRepository = examRepository {
    sceneReady = ValueNotifier(false);
    screenState = ValueNotifier(HomeScreenState.initial);

    exams = ValueNotifier<List<Exam>>([]);
    pages = ValueNotifier<List<ExamPage>>([]);

    initCommand = Command.createSyncNoResult<PageController>(_init);
    loadCommand = Command.createAsyncNoParamNoResult(_load);
    addExamCommand = Command.createAsyncNoResult<Exam>(_addExam);
  }

  final ExamRepository _examRepository;
  final TurnOffset turnOffset;

  late final ValueNotifier<bool> sceneReady;
  late final ValueNotifier<List<Exam>> exams;
  late final ValueNotifier<List<ExamPage>> pages;
  late final ValueNotifier<HomeScreenState> screenState;
  late final PageController _pageController;

  late final Command<PageController, void> initCommand;
  late final Command<void, void> loadCommand;
  late final Command<Exam, void> addExamCommand;

  void _init(PageController pageController) {
    _pageController = pageController;
  }

  Future<void> _load() async {
    screenState.value = HomeScreenState.loading;
    final result = await _examRepository.getExamsList();
    switch (result) {
      case Ok<List<Exam>>():
        exams.value = List<Exam>.from(result.value);
        screenState.value = HomeScreenState.loaded;
        break;
      case Error<List<Exam>>():
        screenState.value = HomeScreenState.error;
        exams.value = [];
        break;
    }
    _refresh();
  }

  void _refresh() {
    _updatePages();
    sceneReady.value = true;

    _pageController.addListener(() {
      final page = _pageController.page ?? 0.0;
      final intPart = page.floor();
      final decimalPart = page - intPart;

      if (decimalPart != 0 && intPart > 0 && intPart < exams.value.length) {
        var lIndex = intPart - 1;
        var rIndex = intPart;

        exams.value.elementAt(lIndex).rotate(decimalPart * turnOffset.radians);
        exams.value
            .elementAt(rIndex)
            .rotate(-(1 - decimalPart) * turnOffset.radians);
      }
      notifyListeners();
    });

    if (exams.value.isNotEmpty && _pageController.hasClients) {
      _pageController.jumpToPage(1);
    }
  }

  void _updatePages() {
    final examPages = exams.value.asMap().entries.map((entry) {
      final index = entry.key;
      final exam = entry.value;

      final lVerticalText = switch (index) {
        0 => 'NEW EXAM',
        _ => exams.value.elementAt(index - 1).name,
      };

      var rVerticalText = '';
      if (index + 1 < exams.value.length) {
        rVerticalText = exams.value.elementAt(index + 1).name;
      }

      return ExamPage(
        exam: exam,
        lVerticalText: lVerticalText,
        rVerticalText: rVerticalText,
      );
    });
    pages.value = [...examPages];
  }

  Future<void> _addExam(Exam exam) async {
    await _examRepository.create(exam);
    await _load();
  }

  void addExamsListener(VoidCallback listener) {
    exams.addListener(listener);
  }

  void removeExamsListener(VoidCallback listener) {
    exams.removeListener(listener);
  }
}

enum TurnOffset {
  turn45(pi / 4),
  turn60(pi / 3),
  turn90(pi / 2);

  const TurnOffset(this.radians);

  final num radians;
}
