import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';

import '../../../data/repositories/avatar/avatar_repository.dart';
import '../../../data/repositories/exam/exam_repository.dart';
import '../../../domain/models/avatar/avatar.dart';
import '../../../domain/models/exam/exam.dart';
import '../../../utils/result.dart';

enum RoadmapScreenState { initial, loading, loaded, error }

class RoadmapScreenViewModel extends ChangeNotifier {
  RoadmapScreenViewModel({
    required AvatarRepository avatarRepository,
    required ExamRepository examRepository,
  }) : _avatarRepository = avatarRepository,
       _examRepository = examRepository {
    {
      state = ValueNotifier(RoadmapScreenState.initial);
      avatar = ValueNotifier(null);
      exams = ValueNotifier<List<Exam>>([]);
      loadCommand = Command.createAsyncNoParamNoResult(_load);
      addExamCommand = Command.createAsyncNoResult<Exam>(_addExam);
    }
  }

  final AvatarRepository _avatarRepository;
  final ExamRepository _examRepository;

  late final ValueNotifier<Avatar?> avatar;
  late final ValueNotifier<List<Exam>> exams;
  late final ValueNotifier<RoadmapScreenState> state;

  late final Command<void, void> loadCommand;
  late final Command<Exam, void> addExamCommand;

  Future<void> _load() async {
    state.value = RoadmapScreenState.loading;

    final avatarResult = await _avatarRepository.get();
    switch (avatarResult) {
      case Ok<Avatar>():
        avatar.value = avatarResult.value;
        break;
      case Error<Avatar>():
        state.value = RoadmapScreenState.error;
        return;
    }

    final examsResult = await _examRepository.getExamsList();
    switch (examsResult) {
      case Ok<List<Exam>>():
        exams.value = List<Exam>.from(examsResult.value);
        state.value = RoadmapScreenState.loaded;
        break;
      case Error<List<Exam>>():
        exams.value = [];
        state.value = RoadmapScreenState.error;
        return;
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
