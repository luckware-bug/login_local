// lib/features/auth/domain/usecases/register_user.dart

import '../repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<bool> call(String username, String password) async {
    return await repository.register(username, password);
  }
}



