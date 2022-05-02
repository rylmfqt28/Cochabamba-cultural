import 'dart:io';

import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';

import 'package:cochabambacultural/user/model/user_model.dart';

import 'package:cochabambacultural/utils/snack_messages.dart';
import 'package:cochabambacultural/utils/app_colors.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  final AppColors colorApp = AppColors();

  SnackMessages messages = SnackMessages();

  UserBloc() : super(const UserInitialstate()) {
    on<SignIn>((event, emit) async {
      try {
        await _auth
            .signInWithEmailAndPassword(
                email: event.email.trim(), password: event.password.trim())
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
        await _errorAuthentication(error.code, event.context, 150);
      }
    });

    on<SignOut>((event, emit) async {
      try {
        await _auth.signOut();
        Navigator.pushNamed(event.context, 'welcome_screen');
        emit(const UserInitialstate());
      } on FirebaseAuthException catch (error) {
        await _errorAuthentication(error.code, event.context, 150);
      }
    });

    on<ResetPassword>((event, emit) async {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: event.email.trim())
            .then((value) {
          Navigator.of(event.context, rootNavigator: true).pop('dialog');
          _successDialog(
              "Se envió un mensaje a su correo para recuperar su cuenta.",
              event.context,
              150);
        });
      } on FirebaseAuthException catch (error) {
        Navigator.of(event.context, rootNavigator: true).pop('dialog');
        await _errorAuthentication(error.code, event.context, 190);
      }
    });

    on<SignUp>((event, emit) async {
      try {
        await _auth
            .createUserWithEmailAndPassword(
                email: event.email.trim(), password: event.password.trim())
            .then((value) async {
          User? user = _auth.currentUser;
          UserModel userModel = UserModel();
          userModel.uid = user!.uid;
          userModel.name = event.name.trim();
          userModel.email = user.email;
          userModel.picture =
              "https://firebasestorage.googleapis.com/v0/b/cochabamba-cultural.appspot.com/o/user-profile-pictures%2Fdefault-picture.png?alt=media&token=c01a7856-6976-4a09-afca-c88cfd36d84c";

          await _fireStore
              .collection("users")
              .doc(user.uid)
              .set(userModel.toMap())
              .then((value) {
            emit(UserSetState(userModel));
            Navigator.pushNamed(event.context, 'user_home_screen');
          });
        });
      } on FirebaseAuthException catch (error) {
        await _errorAuthentication(error.code, event.context, 150);
      }
    });

    on<UpdateNameUser>((event, emit) async {
      try {
        await _fireStore.collection("users").doc(event.uidUser).update({
          'name': event.newName,
        }).then((value) {
          emit(UserSetState(state.user!.copyWith(name: event.newName)));
        }).then((value) {
          Navigator.of(event.context, rootNavigator: true).pop('dialog');
          _successDialog(
              "Su nombre se ha actualizado correctamente.", event.context, 190);
        });
      } on FirebaseException catch (error) {
        Navigator.of(event.context, rootNavigator: true).pop('dialog');
        await _errorStore(error.code, event.context, 190);
      }
    });

    on<UpdateUserPassword>((event, emit) async {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        await user?.updatePassword(event.newPassword).then((value) {
          add(SignOut(context: event.context));
          _successDialog("Su contraseña se ha actualizado correctamente.",
              event.context, 150);
        });
      } on FirebaseAuthException catch (error) {
        Navigator.of(event.context, rootNavigator: true).pop('dialog');
        await _errorAuthentication(error.code, event.context, 190);
      }
    });

    // For ios add permission
    on<UpdateImageUser>((event, emit) async {
      try {
        final _storage = FirebaseStorage.instance;

        final imageSelected =
            await ImagePicker().pickImage(source: ImageSource.gallery);

        if (imageSelected != null) {
          final pathImage = File(imageSelected.path);
          await _storage
              .ref()
              .child('user-profile-pictures/${state.user!.uid}')
              .putFile(pathImage)
              .then((TaskSnapshot taskSnapshot) async {
            await taskSnapshot.ref.getDownloadURL().then((value) async {
              await _fireStore
                  .collection("users")
                  .doc(state.user!.uid)
                  .update({'picture': value}).then((valueComp) async {
                emit(UserSetState(state.user!.copyWith(picture: value)));
              });
              // emit(UserSetState(state.user!.copyWith(picture: value)));
            });
          }).then((value) {
            _successDialog(
                "Su foto de perfil se ha actualizado.", event.context, 190);
          });
        }
      } on FirebaseException catch (error) {
        await _errorStore(error.code, event.context, 150);
      }
    });
  }

  /*
  * SncakBar message for error in login, register and reset password
  */
  _errorAuthentication(String error, BuildContext context, double margin) {
    switch (error) {
      case "wrong-password":
        ScaffoldMessenger.of(context).showSnackBar(messages.getSnack(
            "El correo electrónico o la contraseña son incorrectas.",
            colorApp.errorColor,
            context,
            margin));
        break;
      case "user-not-found":
        ScaffoldMessenger.of(context).showSnackBar(messages.getSnack(
            "El correo electrónico ingresado no se encuentra registrado.",
            colorApp.errorColor,
            context,
            margin));
        break;
      case "user-disabled":
        ScaffoldMessenger.of(context).showSnackBar(messages.getSnack(
            "Su cuenta se encuentra suspendida.",
            colorApp.errorColor,
            context,
            margin));
        break;
      case "invalid-email":
        ScaffoldMessenger.of(context).showSnackBar(messages.getSnack(
            "El correo electrónico ingresado no es válido.",
            colorApp.errorColor,
            context,
            margin));
        break;
      case "email-already-in-use":
        ScaffoldMessenger.of(context).showSnackBar(messages.getSnack(
            "El correo electrónico ingresado ya se encuentra registrado.",
            colorApp.errorColor,
            context,
            margin));
        break;
      case "operation-not-allowed":
        ScaffoldMessenger.of(context).showSnackBar(messages.getSnack(
            "La operación que desea realizar no se encuentra disponible.",
            colorApp.errorColor,
            context,
            margin));
        break;
      case "too-many-requests":
        ScaffoldMessenger.of(context).showSnackBar(messages.getSnack(
            "Se están realizando demasiadas solicitudes.",
            colorApp.errorColor,
            context,
            margin));
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(messages.getSnack(
            "Ha ocurrido un error intente de nuevo.",
            colorApp.errorColor,
            context,
            margin));
    }
  }

  _errorStore(String error, BuildContext context, double margin) {
    switch (error) {
      case "unauthenticated":
        ScaffoldMessenger.of(context).showSnackBar(messages.getSnack(
            "Ha ocurrido un error de autenticacion.",
            colorApp.errorColor,
            context,
            margin));
        break;
      case "unauthorized":
        ScaffoldMessenger.of(context).showSnackBar(messages.getSnack(
            "No estás autorizado para realizar la acción deseada.",
            colorApp.errorColor,
            context,
            margin));
        break;
      case "retry-limit-exceeded":
        ScaffoldMessenger.of(context).showSnackBar(messages.getSnack(
            "Se ha superado el límite de tiempo máximo de espera, intente de nuevo.",
            colorApp.errorColor,
            context,
            margin));
        break;
      case "canceled":
        ScaffoldMessenger.of(context).showSnackBar(messages.getSnack(
            "Se ha cancelado la operación, intente de nuevo.",
            colorApp.errorColor,
            context,
            margin));
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(messages.getSnack(
            "Ha ocurrido un error intente de nuevo.",
            colorApp.errorColor,
            context,
            margin));
    }
  }

  _successDialog(String message, BuildContext context, double margin) {
    ScaffoldMessenger.of(context).showSnackBar(
        messages.getSnack(message, colorApp.successful, context, margin));
  }
}
