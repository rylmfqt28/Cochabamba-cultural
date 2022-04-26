part of 'user_bloc.dart';

@immutable
abstract class UserState {
  final bool existUser;
  final UserModel? user;

  const UserState({this.existUser = false, this.user});
}

class UserInitialstate extends UserState {
  const UserInitialstate() : super(existUser: false, user: null);
}

class UserSetState extends UserState {
  final UserModel newuser;
  const UserSetState(this.newuser) : super(existUser: true, user: newuser);
}
