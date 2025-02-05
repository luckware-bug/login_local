// lib/app.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'config/routes.dart'; // Importamos routes.dart
import 'features/auth/presentation/blocs/auth_bloc.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => GetIt.instance<AuthBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Clean Architecture',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: goRouter, // 🔹 Aquí se usa el GoRouter definido en routes.dart
      ),
    );
  }
}
