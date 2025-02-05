// lib/features/auth/domain/repositories/auth_repository.dart

abstract class AuthRepository {
  Future<bool> login(String username, String password);
  Future<bool> register(String username, String password);
}
