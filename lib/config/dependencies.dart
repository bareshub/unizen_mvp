import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:unizen/data/repositories/auth/auth_repository.dart';
import 'package:unizen/data/repositories/auth/auth_repository_dev.dart';

/// Shared providers for all configurations.
List<SingleChildWidget> _sharedProviders = [];

/// Configure dependencies for remote data.
/// This dependency list uses repositories that connect to a remote server.
List<SingleChildWidget> get providersRemote {
  return [..._sharedProviders];
}

List<SingleChildWidget> get providersLocal {
  return [
    ChangeNotifierProvider.value(value: AuthRepositoryDev() as AuthRepository),
    ..._sharedProviders,
  ];
}
