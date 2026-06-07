import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/repositories/auth/auth_repository.dart';
import '../data/repositories/auth/auth_repository_dev.dart';
import '../data/repositories/avatar/avatar_repository.dart';
import '../data/repositories/avatar/avatar_repository_local.dart';
import '../data/repositories/boss/boss_repository.dart';
import '../data/repositories/boss/boss_repository_local.dart';
import '../data/repositories/exam/exam_repository.dart';
import '../data/repositories/exam/exam_repository_local.dart';
import '../data/repositories/exam/exam_repository_remote.dart';
import '../data/repositories/avatar/avatar_repository_remote.dart';
import '../data/repositories/boss/boss_repository_remote.dart';
import '../data/services/local/local_data_service.dart' show HardcodedLocalDataService;
import '../data/services/local/local_data_service_interface.dart';

/// Shared providers for all configurations.
List<SingleChildWidget> _sharedProviders = [];

/// Configure dependencies for remote data.
/// This dependency list uses repositories that connect to a remote server.
/// Currently wired with stub implementations that throw UnimplementedError.
/// Replace with real remote implementations when backend is ready.
List<SingleChildWidget> get providersRemote {
  return [
    Provider<ExamRepository>(
      create: (_) => ExamRepositoryRemote(),
    ),
    Provider<BossRepository>(
      create: (_) => BossRepositoryRemote(),
    ),
    Provider<AvatarRepository>(
      create: (_) => AvatarRepositoryRemote(),
    ),
    ChangeNotifierProvider.value(value: AuthRepositoryDev() as AuthRepository),
    ..._sharedProviders,
  ];
}

List<SingleChildWidget> get providersLocal {
  return [
    Provider<LocalDataService>.value(value: HardcodedLocalDataService()),
    Provider(
      create:
          (context) =>
              AvatarRepositoryLocal(
                    localDataService: context.read<LocalDataService>(),
                  )
                  as AvatarRepository,
    ),
    Provider(
      create:
          (context) =>
              ExamRepositoryLocal(
                    localDataService: context.read<LocalDataService>(),
                  )
                  as ExamRepository,
    ),
    Provider(
      create:
          (context) =>
              BossRepositoryLocal(
                    localDataService: context.read<LocalDataService>(),
                  )
                  as BossRepository,
    ),
    ChangeNotifierProvider.value(value: AuthRepositoryDev() as AuthRepository),
    ..._sharedProviders,
  ];
}
