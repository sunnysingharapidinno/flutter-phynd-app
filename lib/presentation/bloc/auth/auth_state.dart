import 'package:equatable/equatable.dart';
import 'package:phynd_app/data/models/response/profile_model.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final Profile? profile;
  final String? errorMessage;
  final bool isPublisher;

  const AuthState({
    this.status = AuthStatus.initial,
    this.profile,
    this.errorMessage,
    this.isPublisher = false,
  });

  AuthState copyWith({
    AuthStatus? status,
    Profile? profile,
    String? errorMessage,
    bool? isPublisher,
  }) {
    return AuthState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      errorMessage: errorMessage ?? this.errorMessage,
      isPublisher: isPublisher ?? this.isPublisher,
    );
  }

  @override
  List<Object?> get props => [status, profile, errorMessage, isPublisher];
}
