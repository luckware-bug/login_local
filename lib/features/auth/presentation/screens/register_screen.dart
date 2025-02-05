import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:login_local/core/widgets/password_text_field.dart';
import '../blocs/auth_bloc.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registro")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: "Usuario"),
            ),
            PasswordTextField(controller: passwordController),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().register(
                      usernameController.text,
                      passwordController.text,
                    );
              },
              child: Text("Registrar"),
            ),
            BlocListener<AuthBloc, bool?>(
              listener: (context, state) async {
                if (state == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text("Registro exitoso, inicia sesión ✅")),
                  );
                  await Future.delayed(Duration(
                      milliseconds: 500)); // 🔹 Espera antes de ir al Login
                  GoRouter.of(context).go('/login'); // 🔹 Redirige al Login
                } else if (state == false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("El usuario ya existe ❌")),
                  );
                }
              },
              child: Container(),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                GoRouter.of(context).go('/login');
              },
              child: Text("¿Ya tienes cuenta? Inicia sesión"),
            ),
          ],
        ),
      ),
    );
  }
}
