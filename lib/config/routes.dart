import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login_local/features/auth/presentation/screens/home_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomeScreen(), // ✅ Ahora sí debería funcionar
    ),
  ],
);
