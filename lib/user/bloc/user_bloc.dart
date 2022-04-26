import 'package:flutter/material.dart';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:cochabambacultural/user/model/user_model.dart';
import 'package:cochabambacultural/utils/snack_messages.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
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
        switch (error.code) {
          case "wrong-password":
            ScaffoldMessenger.of(event.context).showSnackBar(messages.getSnack(
                "La dirección de correo electrónico o la contraseña son incorrectas.",
                const Color(0xffF0627C)));
            break;
          case "user-not-found":
            ScaffoldMessenger.of(event.context).showSnackBar(messages.getSnack(
                "El correo ingresado no se encuentra registrado.",
                const Color(0xffF0627C)));
            break;
          case "user-disabled":
            ScaffoldMessenger.of(event.context).showSnackBar(messages.getSnack(
                "Su cuenta esta suspendida", const Color(0xffF0627C)));
            break;
          default:
            ScaffoldMessenger.of(event.context).showSnackBar(messages.getSnack(
                "Ha ocurrido un error intente de nuevo.",
                const Color(0xffF0627C)));
        }
      }
    });

    on<SignOut>((event, emit) async {
      try {
        await _auth.signOut();
        Navigator.pushNamed(event.context, 'welcome_screen');
        emit(const UserInitialstate());
      } on FirebaseAuthException catch (error) {
        ScaffoldMessenger.of(event.context).showSnackBar(messages.getSnack(
            "Ha ocurrido un error intente de nuevo.", const Color(0xffF0627C)));
      }
    });
  }
}
