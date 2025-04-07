import 'package:pontodevenda/domain/models/user.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> allUsers;
  final List<User> filteredUsers;

  UserLoaded(this.allUsers, [List<User>? filtered])
    : filteredUsers = filtered ?? allUsers;
}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}
