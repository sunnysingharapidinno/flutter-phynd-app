import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phynd_app/core/routing/app_routes.dart';
import 'package:phynd_app/core/theme/dark_theme.dart';
import 'package:phynd_app/data/services/user_service.dart';
import 'package:phynd_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:phynd_app/presentation/bloc/auth/auth_event.dart';

class MyApp extends StatelessWidget {
  final UserService userService;

  const MyApp({super.key, required this.userService});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(userService: userService),
      child: const AppInitializer(),
    );
  }
}

class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    try {
      final authBloc = context.read<AuthBloc>();
      authBloc.add(GetUserDetails());
    } catch (e) {
      print('Auth check error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Phynd App',
      theme: darkTheme,
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: AppRoutes.home,
    );
  }
}
