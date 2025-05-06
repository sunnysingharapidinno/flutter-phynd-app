import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phynd_app/core/routing/app_routes.dart';
import 'package:phynd_app/data/services/user_service.dart';
import 'package:phynd_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:phynd_app/presentation/bloc/auth/auth_event.dart';
import 'package:phynd_app/presentation/bloc/auth/auth_state.dart';
import 'package:phynd_app/presentation/widgets/forms/login_form.dart';
import 'package:phynd_app/core/utils/storage_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final UserService _userService = UserService();
  final StorageService _storage = StorageService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _storage.init();
  }

  Future<void> _handleLogin(
      BuildContext context, String email, String password) async {
    try {
      setState(() {
        _isLoading = true;
      });

      final authBloc = context.read<AuthBloc>();

      await _userService.loginUser(userId: email, password: password);

      authBloc.add(
        GetUserDetails(),
      );

      // Navigate to home page after successful login
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Login error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: LoginForm(
            onSubmit: (email, password) {
              _handleLogin(context, email, password);
            },
            isLoading: _isLoading,
          ),
        );
      },
    );
  }
}
