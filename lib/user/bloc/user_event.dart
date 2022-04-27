part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class SignIn extends UserEvent {
  final String email;
  final String password;
  final BuildContext context;
  SignIn({required this.email, required this.password, required this.context});
}

class SignUp extends UserEvent {
  final String name;
  final String email;
  final String password;
  final BuildContext context;

  SignUp(
      {required this.name,
      required this.email,
      required this.password,
      required this.context});
}

class SignOut extends UserEvent {
  final BuildContext context;
  SignOut({required this.context});
}

class ResetPassword extends UserEvent {
  final String email;
  final BuildContext context;
  ResetPassword({required this.email, required this.context});
}
