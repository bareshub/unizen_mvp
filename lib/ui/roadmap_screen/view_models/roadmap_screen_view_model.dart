import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:unizen/utils/result.dart';

import '../../../data/repositories/exam/exam_repository.dart';
import '../../../domain/models/exam/exam.dart';

enum RoadmapScreenState { initial, loading, loaded, error }

class RoadmapScreenViewModel extends ChangeNotifier {
  RoadmapScreenViewModel({required ExamRepository examRepository})
    : _examRepository = examRepository {
    state = ValueNotifier(RoadmapScreenState.initial);

    exams = ValueNotifier<List<Exam>>([]);

    loadCommand = Command.createAsyncNoParamNoResult(_load);
    addExamCommand = Command.createAsyncNoResult<Exam>(_addExam);
  }

  final ExamRepository _examRepository;

  late final ValueNotifier<List<Exam>> exams;
  late final ValueNotifier<RoadmapScreenState> state;

  late final Command<void, void> loadCommand;
  late final Command<Exam, void> addExamCommand;

  Future<void> _load() async {
    state.value = RoadmapScreenState.loading;

    final result = await _examRepository.getExamsList();
    switch (result) {
      case Ok<List<Exam>>():
        exams.value = List<Exam>.from(
          result.value,
        ); // Create new list to ensure notification
        state.value = RoadmapScreenState.loaded;
        break;
      case Error<List<Exam>>():
        exams.value = [];
        state.value = RoadmapScreenState.error;
        break;
    }
  }

  Future<void> _addExam(Exam exam) async {
    try {
      state.value = RoadmapScreenState.loading;
      await _examRepository.create(exam);
      await _load();
    } catch (e) {
      state.value = RoadmapScreenState.error;
      exams.value = [];
    }
  }
}
