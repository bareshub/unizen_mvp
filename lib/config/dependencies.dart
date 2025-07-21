import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/repositories/auth/auth_repository.dart';
import '../data/repositories/auth/auth_repository_dev.dart';
import '../data/repositories/exam/exam_repository.dart';
import '../data/repositories/exam/exam_repository_local.dart';
import '../data/services/local/local_data_service.dart';

/// Shared providers for all configurations.
List<SingleChildWidget> _sharedProviders = [];

/// Configure dependencies for remote data.
/// This dependency list uses repositories that connect to a remote server.
List<SingleChildWidget> get providersRemote {
  return [..._sharedProviders];
}

List<SingleChildWidget> get providersLocal {
  return [
    Provider.value(value: LocalDataService()),
    Provider(
      create:
          (context) =>
              ExamRepositoryLocal(localDataService: context.read())
                  as ExamRepository,
    ),
    ChangeNotifierProvider.value(value: AuthRepositoryDev() as AuthRepository),
    ..._sharedProviders,
  ];
}
