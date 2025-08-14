import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';

import '../../../data/repositories/boss/boss_repository.dart';
import '../../../domain/models/boss/boss.dart';
import '../../../utils/result.dart';

class AddExamPageViewModel extends ChangeNotifier {
  AddExamPageViewModel({required BossRepository bossRepository})
    : _bossRepository = bossRepository {
    bosses = ValueNotifier([]);

    selectedBossIndex = ValueNotifier(1);
    examName = ValueNotifier('');

    loadCommand = Command.createAsyncNoParamNoResult(_load);
    setExamNameCommand = Command.createSyncNoResult<String>(_setExamName);
    setSelectedBossIndexCommand = Command.createSyncNoResult<int>(
      _setSelectedBossIndex,
    );
  }

  final BossRepository _bossRepository;

  late final ValueNotifier<int> selectedBossIndex;
  late final ValueNotifier<String> examName;

  late final ValueNotifier<List<Boss>> bosses;
  late final Command<void, void> loadCommand;
  late final Command<String, void> setExamNameCommand;
  late final Command<int, void> setSelectedBossIndexCommand;

  List<int> get carouselFlexWeights => [3, 5, 3];

  bool get canCarouselMoveLeft => selectedBossIndex.value > 0;

  bool get canCarouselMoveRight =>
      selectedBossIndex.value < bosses.value.length - 1;

  // TODO IMPROVE CHECK
  bool get isExamNameValid => examName.value.isNotEmpty;

  Future<void> _load() async {
    final result = await _bossRepository.getBossesList();

    switch (result) {
      case Ok<List<Boss>>():
        bosses.value = result.value;
        notifyListeners();
        break;
      case Error<List<Boss>>():
        // TODO log warning / error
        break;
    }
  }

  void _setExamName(String newExamName) {
    examName.value = newExamName;
    notifyListeners();
  }

  void _setSelectedBossIndex(int index) {
    selectedBossIndex.value = index.clamp(0, bosses.value.length - 1);
    notifyListeners();
  }
}
