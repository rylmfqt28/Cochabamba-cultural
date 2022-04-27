part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

/*
* Inicio de sesion
* Registro de usuarios
* recuperar contraseña
*/

class SignIn extends UserEvent {
  final String email;
  final String password;
  final BuildContext context;
  SignIn({required this.email, required this.password, required this.context});
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
