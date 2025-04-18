// lib/core/bloc/user_event.dart

import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUserDetails extends AuthEvent {
  GetUserDetails();

  @override
  List<Object?> get props => [];
}

class LogoutUser extends AuthEvent {
  LogoutUser();

  @override
  List<Object?> get props => [];
}
