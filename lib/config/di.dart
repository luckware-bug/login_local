// lib/config/di.dart
import 'package:get_it/get_it.dart';
import '../core/services/local_storage_service.dart';
import '../features/auth/data/datasources/auth_local_data_source.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/login_user.dart';
import '../features/auth/domain/usecases/register_user.dart';
import '../features/auth/presentation/blocs/auth_bloc.dart';

final sl = GetIt.instance;

void setupLocator() {
  sl.registerLazySingleton<LocalStorageService>(() => LocalStorageService());

  // DataSource
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl()));

  // UseCases
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));

  // Bloc
  sl.registerFactory(() => AuthBloc(sl(), sl()));
}
