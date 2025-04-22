import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phynd_app/data/services/user_service.dart';
import 'package:phynd_app/core/utils/storage_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserService _userService;
  final StorageService _storage = StorageService();

  AuthBloc({required UserService userService})
      : _userService = userService,
        super(AuthState()) {
    on<GetUserDetails>(_onGetUserDetails);
    on<LogoutUser>(_onLogoutUser);
    _storage.init();
  }

  Future<void> _onGetUserDetails(
      GetUserDetails event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));

      final token = await _storage.get('auth_token');
      print(token);
      if (token == null) {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
        return;
      }

      final profile = await _userService.getUserMyDetails();

      print(profile);

      emit(state.copyWith(
        status: AuthStatus.authenticated,
        profile: profile,
        isPublisher: profile.isPublisher ?? false,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLogoutUser(LogoutUser event, Emitter<AuthState> emit) async {
    try {
      await _storage.clear();

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
