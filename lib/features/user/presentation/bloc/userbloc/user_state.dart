part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class Empty extends UserState {
  @override
  List<Object> get props => [];
}

class Loading extends UserState {
  @override
  List<Object> get props => [];
}

class Loaded extends UserState {
  final User user;

  Loaded({@required this.user});
  @override
  List<Object> get props => [this.user];
}

class Error extends UserState {
  final String message;
  Error(this.message);
  List<Object> get props => [this.message];
}
