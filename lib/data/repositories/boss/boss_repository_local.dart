import 'package:unizen/data/services/local/local_data_service.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/models/boss/boss.dart';
import '../../../utils/result.dart';
import 'boss_repository.dart';

/// Local implementation of [BossRepository]
class BossRepositoryLocal implements BossRepository {
  bool _isInitialized = false;

  final _bosses = List<Boss>.empty(growable: true);
  final LocalDataService _localDataService;

  BossRepositoryLocal({required LocalDataService localDataService})
    : _localDataService = localDataService;

  @override
  Future<Result<Uuid>> create(Boss boss) async {
    _bosses.add(boss);
    return Result.ok(boss.id);
  }

  @override
  Future<Result<void>> delete(Uuid id) async {
    _bosses.removeWhere((x) => x.id == id);
    return Result.ok(null);
  }

  @override
  Future<Result<List<Boss>>> getBossesList() async {
    if (!_isInitialized) {
      _createDefaultBossesList();
      _isInitialized = true;
    }
    return Result.ok(_bosses);
  }

  void _createDefaultBossesList() {
    _bosses.addAll(_localDataService.getBosses());
  }
}
