import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  Future<void> saveUser(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_$username', password);
  }

  Future<String?> getUserPassword(String username) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_$username'); // 🔹 Devuelve `null` si el usuario no existe
  }

  Future<void> deleteUser(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_$username');
  }

  Future<void> clearAllUsers() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // 🔹 Borra todos los usuarios
  }
}
