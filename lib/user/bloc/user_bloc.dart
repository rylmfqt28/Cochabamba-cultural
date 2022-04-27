import 'package:flutter/material.dart';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:cochabambacultural/user/model/user_model.dart';

import 'package:cochabambacultural/utils/snack_messages.dart';
import 'package:cochabambacultural/utils/app_colors.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  final AppColors colorApp = AppColors();

  SnackMessages messages = SnackMessages();

  UserBloc() : super(const UserInitialstate()) {
    /*
    * Registro de usuarios
    * recuperar contraseña
    */
    on<SignIn>((event, emit) async {
      try {
        await _auth
            .signInWithEmailAndPassword(
                email: event.email, password: event.password)
            .then((value) async => {
                  _auth.authStateChanges().listen((User? user) async {
                    if (user != null) {
                      await _fireStore
                          .collection("users")
                          .doc(user.uid)
                          .get()
                          .then((value) async {
                        emit(UserSetState(UserModel.fromMap(value.data())));
                      });
                    } else {
                      Navigator.pushNamed(event.context, 'welcome_screen');
                    }
                  })
                })
            .then((value) =>
                Navigator.pushNamed(event.context, 'user_home_screen'));
      } on FirebaseAuthException catch (error) {
        await _errorAuthentication(error.code, event.context);
        // switch (error.code) {
        //   case "wrong-password":
        //     ScaffoldMessenger.of(event.context).showSnackBar(messages.getSnack(
        //         "La dirección de correo electrónico o la contraseña son incorrectas.",
        //         const Color(0xffF0627C)));
        //     break;
        //   case "user-not-found":
        //     ScaffoldMessenger.of(event.context).showSnackBar(messages.getSnack(
        //         "El correo ingresado no se encuentra registrado.",
        //         const Color(0xffF0627C)));
        //     break;
        //   case "user-disabled":
        //     ScaffoldMessenger.of(event.context).showSnackBar(messages.getSnack(
        //         "Su cuenta esta suspendida", const Color(0xffF0627C)));
        //     break;
        //   default:
        //     ScaffoldMessenger.of(event.context).showSnackBar(messages.getSnack(
        //         "Ha ocurrido un error intente de nuevo.",
        //         const Color(0xffF0627C)));
        // }
      }
    });

    on<SignOut>((event, emit) async {
      try {
        await _auth.signOut();
        Navigator.pushNamed(event.context, 'welcome_screen');
        emit(const UserInitialstate());
      } on FirebaseAuthException catch (error) {
        await _errorAuthentication(error.code, event.context);
        // ScaffoldMessenger.of(event.context).showSnackBar(messages.getSnack(
        //     "Ha ocurrido un error intente de nuevo.", const Color(0xffF0627C)));
      }
    });

    on<ResetPassword>((event, emit) async {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: event.email)
            .then((value) {
          Navigator.of(event.context, rootNavigator: true).pop('dialog');
          ScaffoldMessenger.of(event.context).showSnackBar(messages.getSnack(
              "Se envio un mensaje a su correo para recuperar su cuenta.",
              colorApp.successful));
        });
      } on FirebaseAuthException catch (error) {
        Navigator.of(event.context, rootNavigator: true).pop('dialog');
        await _errorAuthentication(error.code, event.context);
      }
    });
  }

  /*
  * SncakBar message for error in login, register and reset password
  */
  _errorAuthentication(String error, BuildContext context) {
    switch (error) {
      case "wrong-password":
        ScaffoldMessenger.of(context).showSnackBar(messages.getSnack(
            "La dirección de correo electrónico o la contraseña son incorrectas.",
            colorApp.errorColor));
        break;
      case "user-not-found":
        ScaffoldMessenger.of(context).showSnackBar(messages.getSnack(
            "El correo ingresado no se encuentra registrado.",
            colorApp.errorColor));
        break;
      case "user-disabled":
        ScaffoldMessenger.of(context).showSnackBar(messages.getSnack(
            "Su cuenta se encuentra suspendida.", colorApp.errorColor));
        break;
      case "invalid-email":
        ScaffoldMessenger.of(context).showSnackBar(messages.getSnack(
            "El correo electronico ingresado no es valido.",
            colorApp.errorColor));
        break;
      case "email-already-in-use":
        ScaffoldMessenger.of(context).showSnackBar(messages.getSnack(
            "El correo ingresado ya se encuentra registrado.",
            colorApp.errorColor));
        break;
      case "operation-not-allowed":
        ScaffoldMessenger.of(context).showSnackBar(messages.getSnack(
            "La operacion que desea realizar no se encuentra disponible.",
            colorApp.errorColor));
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(messages.getSnack(
            "Ha ocurrido un error intente de nuevo.", colorApp.errorColor));
    }
  }
}
