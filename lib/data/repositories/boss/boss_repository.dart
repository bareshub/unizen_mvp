import 'package:uuid/uuid.dart';

import '../../../domain/models/boss/boss.dart';
import '../../../utils/result.dart';

abstract class BossRepository {
  /// Creates a new [Boss] for the current user
  /// Returns the ID given to the new [Boss]
  Future<Result<Uuid>> create(Boss boss);

  /// Delete a [Boss] for the current user
  Future<Result<void>> delete(Uuid id);

  /// Returns the list of [Boss] for the current user
  Future<Result<List<Boss>>> getBossesList();
}
