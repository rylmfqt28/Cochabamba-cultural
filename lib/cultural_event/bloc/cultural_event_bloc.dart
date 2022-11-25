import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/exception_firestore.dart';
import 'package:cochabambacultural/utils/snack_messages.dart';

import 'package:cochabambacultural/cultural_event/repository/upload_images.dart';

import 'package:cochabambacultural/cultural_event/model/cultural_event_model.dart';

import 'package:bloc/bloc.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

part 'cultural_event_state.dart';
part 'cultural_event_event.dart';

class CulturalEventBloc extends Bloc<CulturalEventEvent, CulturalEventState> {
  final _fireStore = FirebaseFirestore.instance;

  final ExceptionFirestore _errorMsg = ExceptionFirestore();

  final AppColors colorApp = AppColors();

  SnackMessages messages = SnackMessages();

  CulturalEventBloc() : super(const CulturalEventInitialState()) {
    on<CreatedCulturalEvent>(((event, emit) async {
      try {
        await UploadImages()
            .uploadPrincipalImage(
                event.culturalEvent.principalImage!, event.culturalEvent.uid!)
            .then((value) => {event.culturalEvent.principalImage = value})
            .then((value) async {
          await UploadImages()
              .uploadSecondaryImages(event.culturalEvent.secondaryImages!,
                  event.culturalEvent.uid!)
              .then((value) => event.culturalEvent.secondaryImages = value)
              .then((value) async {
            await _fireStore
                .collection("events")
                .doc(event.culturalEvent.uid)
                .set(event.culturalEvent.toMap())
                .then((value) {
              emit(CulturalEventSetState(newEvent: event.culturalEvent));
              _successDialog("Evento creado con exito", event.context, 190);
              Navigator.of(event.context).pop();
            });
          });
        });
      } on FirebaseException catch (error) {
        _errorMsg.showMessageException(error.code, event.context, 190);
      }
    }));
  }

  _successDialog(String message, BuildContext context, double margin) {
    ScaffoldMessenger.of(context).showSnackBar(
        messages.getSnack(message, colorApp.successful, context, margin));
  }
}
