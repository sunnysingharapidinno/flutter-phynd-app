import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phynd_app/core/routing/app_routes.dart';
import 'package:phynd_app/core/theme/light_theme.dart';
import 'package:phynd_app/data/services/user_service.dart';
import 'package:phynd_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:phynd_app/presentation/bloc/auth/auth_event.dart';

class MyApp extends StatelessWidget {
  final UserService userService;

  const MyApp({super.key, required this.userService});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = AuthBloc(userService: userService);
        bloc.add(GetUserDetails());
        return bloc;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Phynd App',
        theme: lightTheme,
        routes: AppRoutes.routes,
        initialRoute: AppRoutes.home,
      ),
    );
  }
}
