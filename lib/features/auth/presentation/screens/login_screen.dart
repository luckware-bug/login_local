import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:login_local/core/widgets/password_text_field.dart';
import 'package:login_local/core/widgets/sos_button.dart';
import '../blocs/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             SizedBox(
              width: 100,
              height: 100,
               child: SOSButton(onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("¡Alerta S.O.S activada!")),
                );
                           }),
             ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: "Usuario"),
            ),
            PasswordTextField(controller: passwordController),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().login(
                      usernameController.text,
                      passwordController.text,
                    );
              },
              child: Text("Iniciar Sesión"),
            ),
            SizedBox(height: 20),
            BlocListener<AuthBloc, bool?>(
              listener: (context, state) async {
                if (state == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Login exitoso 🎉")),
                  );
                  await Future.delayed(Duration(
                      milliseconds: 500)); // 🔹 Espera antes de ir al Home
                  GoRouter.of(context).go('/home'); // 🔹 Redirigir al Home
                } else if (state == false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text("Usuario o contraseña incorrectos ❌")),
                  );
                }
              },
              child: Container(),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                GoRouter.of(context).go('/register');
              },
              child: Text("¿No tienes cuenta? Regístrate aquí"),
            ),
          ],
        ),
      ),
    );
  }
}
