import 'package:flutter/foundation.dart';
import 'package:swift_aid/Models/user_model.dart';

@immutable
abstract class UserState {}

@immutable
class UserInitialState extends UserState {}

@immutable
class UserLoadingState extends UserState {}

@immutable
class UserLoadedState extends UserState {
  final UserModel userModel;
  UserLoadedState({required this.userModel});
}

@immutable
class UserErrorState extends UserState {
  final String message;
  UserErrorState({required this.message});
}
