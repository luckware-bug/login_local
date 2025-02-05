import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.localDataSource);

  @override
  Future<bool> login(String username, String password) {
    return localDataSource.login(username, password);
  }

  @override
  Future<bool> register(String username, String password) {
    return localDataSource.register(username, password);
  }
}
