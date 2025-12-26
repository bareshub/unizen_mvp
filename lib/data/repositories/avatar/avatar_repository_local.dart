import 'package:uuid/uuid.dart';

import '../../../data/services/local/local_data_service.dart';
import '../../../domain/models/avatar/avatar.dart';
import '../../../utils/result.dart';
import 'avatar_repository.dart';

/// Local implementation of [AvatarRepository]
class AvatarRepositoryLocal implements AvatarRepository {
  bool _isInitialized = false;
  late Avatar _avatar;

  final LocalDataService _localDataService;

  AvatarRepositoryLocal({required LocalDataService localDataService})
    : _localDataService = localDataService;

  @override
  Future<Result<Uuid>> create(Avatar avatar) async {
    _avatar = avatar;
    return Result.ok(avatar.id);
  }

  @override
  Future<Result<Avatar>> get() async {
    if (!_isInitialized) {
      _avatar = _localDataService.getAvatar();
      _isInitialized = true;
    }
    return Result.ok(_avatar);
  }

  @override
  Future<Result<Uuid>> update(Avatar newAvatar) async {
    _avatar = newAvatar;
    return Result.ok(newAvatar.id);
  }
}
