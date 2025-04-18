// auth_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phynd_app/data/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserService _userService;

  AuthBloc({required UserService userService})
      : _userService = userService,
        super(AuthState()) {
    on<GetUserDetails>(_onGetUserDetails);
    on<LogoutUser>(_onUserLogout);
  }

  Future<void> _onGetUserDetails(
      GetUserDetails event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));

      final profile = await _userService.getUserMyDetails();

      print(profile);

      emit(state.copyWith(
        status: AuthStatus.authenticated,
        profile: profile,
        isPublisher: profile.user.is_publisher,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onUserLogout(LogoutUser event, Emitter<AuthState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.clear();

      emit(state.copyWith(
        status: AuthStatus.unauthenticated,
        profile: null,
        isPublisher: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.unauthenticated,
        profile: null,
        isPublisher: null,
      ));
    }
  }
}
