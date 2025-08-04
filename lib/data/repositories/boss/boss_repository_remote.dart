import 'package:uuid/uuid.dart';

import '../../../domain/models/boss/boss.dart';
import '../../../utils/result.dart';
import 'boss_repository.dart';

class BossRepositoryRemote implements BossRepository {
  @override
  Future<Result<Uuid>> create(Boss boss) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> delete(Uuid id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Boss>>> getBossesList() {
    // TODO: implement getBossesList
    throw UnimplementedError();
  }
}
