import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/register_user.dart';

class AuthBloc extends Cubit<bool?> {
  final LoginUser loginUser;
  final RegisterUser registerUser;

  AuthBloc(this.loginUser, this.registerUser) : super(null);

  void login(String username, String password) async {
    emit(null); // 🔹 Reseteamos el estado antes de emitir un nuevo resultado
    await Future.delayed(Duration(milliseconds: 100)); // 🔹 Pequeño delay para evitar errores de actualización

    final result = await loginUser(username, password);
    emit(result); // 🔹 Ahora el estado se actualiza correctamente
  }

  void register(String username, String password) async {
    final success = await registerUser(username, password);

    if (success) {
      emit(null);
      await Future.delayed(Duration(milliseconds: 100));
      emit(true); // 🔹 Registro exitoso
    } else {
      emit(null);
      await Future.delayed(Duration(milliseconds: 100));
      emit(false); // 🔹 Usuario ya existe
    }
  }
}
