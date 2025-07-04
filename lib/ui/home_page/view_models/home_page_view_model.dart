import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';

import '../models/exam_node.dart';

class HomePageViewModel extends ChangeNotifier {
  late final Command<void, void> addExamCommand;
  late final Command<void, void> deleteExamCommand;

  final List<ExamNode> examNodes; // TODO replace behaviour through repository

  HomePageViewModel({required this.examNodes}) {
    addExamCommand = Command.createSyncNoParamNoResult(() {});
    deleteExamCommand = Command.createSyncNoParamNoResult(() {});
  }

  @override
  void dispose() {
    addExamCommand.dispose();
    deleteExamCommand.dispose();
    super.dispose();
  }
}
