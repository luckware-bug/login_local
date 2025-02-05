// lib/main.dart
import 'package:flutter/material.dart';
import 'config/di.dart'; // Inyección de dependencias
import 'app.dart'; // Archivo principal que configura la app

void main() {
  setupLocator(); // Inicializa las dependencias con GetIt
  runApp(MyApp()); // Lanza la aplicación
}
