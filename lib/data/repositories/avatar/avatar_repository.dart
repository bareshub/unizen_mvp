import 'package:unizen/utils/result.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/models/avatar/avatar.dart';

abstract class AvatarRepository {
  /// Creates the [Avatar] for the current user
  /// Returns the ID given to the [Avatar]
  Future<Result<Uuid>> create(Avatar avatar);

  /// Returns the [Avatar] for the current user
  Future<Result<Avatar>> get();

  /// Update the [Avatar] for the current user
  /// Returns the ID given to the new [Avatar]
  Future<Result<Uuid>> update(Avatar newAvatar);
}
