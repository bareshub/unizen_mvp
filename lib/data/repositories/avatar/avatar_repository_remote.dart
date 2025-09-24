import 'package:uuid/uuid.dart';

import '../../../domain/models/avatar/avatar.dart';
import '../../../utils/result.dart';
import 'avatar_repository.dart';

class AvatarRepositoryRemote implements AvatarRepository {
  @override
  Future<Result<Uuid>> create(Avatar avatar) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Result<Avatar>> get() {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<Result<Uuid>> update(Avatar newAvatar) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
