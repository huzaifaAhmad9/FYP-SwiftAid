import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthloadingState extends AuthState {}

class AuthSucessState extends AuthState {
  final String message;
  AuthSucessState({required this.message});
}

class AuthErrorState extends AuthState {
  final String message;
  AuthErrorState({required this.message});
}

class UserAuthenticatedState extends AuthState {
  final User user;
  UserAuthenticatedState({required this.user});
}
