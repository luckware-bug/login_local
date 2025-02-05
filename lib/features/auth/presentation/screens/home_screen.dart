import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login_local/core/widgets/sos_button.dart';
import '../../../../core/services/local_storage_service.dart';

class HomeScreen extends StatelessWidget {
  final LocalStorageService localStorageService = LocalStorageService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              GoRouter.of(context)
                  .go('/login'); // 🔹 Cierra sesión y vuelve al Login
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
            Text(
              "Bienvenido a la página de inicio 🎉",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await localStorageService
                    .clearAllUsers(); // 🔹 Borra todos los usuarios
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text("Todos los usuarios han sido eliminados")),
                );
              },
              child: Text("Borrar Todos los Usuarios"),
            ),
          ],
        ),
      ),
    );
  }
}
