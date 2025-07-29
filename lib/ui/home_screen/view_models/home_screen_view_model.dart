import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:unizen/ui/home_screen/widgets/add_exam_page.dart';

import '../../../data/repositories/exam/exam_repository.dart';
import '../../animated_scene/view_models/rotation_view_model.dart';
import '../../../utils/result.dart';

import '../../../domain/models/exam/exam.dart';
import '../widgets/exam_page.dart';

class HomeScreenViewModel extends ChangeNotifier {
  final ExamRepository _examRepository;
  final TurnOffset turnOffset;

  late final ValueNotifier<bool> sceneReady;
  late final ValueNotifier<int> pageCount;
  late final Command<void, void> loadCommand;
  late final Command<PageController, void> initCommand;

  List<Exam> _exams = [];
  List<RotationViewModel> rotationViewModels = [];
  List<Widget> _pages = [];
  List<Widget> get pages => _pages;

  HomeScreenViewModel({
    required ExamRepository examRepository,
    this.turnOffset = TurnOffset.turn60,
  }) : _examRepository = examRepository {
    sceneReady = ValueNotifier(false);
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
      _initialize();
    }
  }

  void _updatePageCount() {
    pageCount.value = _exams.length + 1;
    notifyListeners();
  }

  void _updatePages() {
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

      return ExamPageWidget(
        rotationViewModel: rotationViewModels[index],
        exam: exam,
        lVerticalText: lVerticalText,
        rVerticalText: rVerticalText,
      );
    });
    _pages = [
      AddExamPage(rVerticalText: _exams.firstOrNull?.name ?? ''),
      ...examPages,
    ];
  }

  void _initialize() async {
    rotationViewModels = _exams.map((_) => RotationViewModel()).toList();

    _updatePages();
    _updatePageCount();

    sceneReady.value = true;

    notifyListeners();
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
