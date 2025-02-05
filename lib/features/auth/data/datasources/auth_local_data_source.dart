import '../../../../core/services/local_storage_service.dart';

abstract class AuthLocalDataSource {
  Future<bool> login(String username, String password);
  Future<bool> register(String username, String password);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final LocalStorageService localStorage;

  AuthLocalDataSourceImpl(this.localStorage);

  @override
  Future<bool> login(String username, String password) async {
    await Future.delayed(Duration(milliseconds: 200)); // 🔹 Pequeña espera para asegurar la carga de datos
    final storedPassword = await localStorage.getUserPassword(username);

    if (storedPassword == null || storedPassword != password) {
      return false; // 🔹 Retorna `false` si el usuario no existe o la contraseña es incorrecta
    }

    return true; // ✅ Login exitoso
  }

  @override
  Future<bool> register(String username, String password) async {
    final existingPassword = await localStorage.getUserPassword(username);
    if (existingPassword != null) {
      return false; // 🔹 Usuario ya existe
    }

    await localStorage.saveUser(username, password);
    return true; // ✅ Registro exitoso
  }
}
