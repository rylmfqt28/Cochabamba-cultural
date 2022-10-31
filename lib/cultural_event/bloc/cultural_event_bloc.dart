import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cochabambacultural/cultural_event/model/cultural_event_model.dart';

part 'cultural_event_state.dart';
part 'cultural_event_event.dart';

class CulturalEventBloc extends Bloc<CulturalEventEvent, CulturalEventState> {
  final _fireStore = FirebaseFirestore.instance;

  CulturalEventBloc() : super(const CulturalEventInitialState()) {
    on<CreatedCulturalEvent>((event, emit) async => {
          //String docId = await _fireStore.collection("events").doc().id
        });
  }
}
