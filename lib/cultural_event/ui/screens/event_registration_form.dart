import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cochabambacultural/cultural_event/bloc/cultural_event_bloc.dart';
import 'package:cochabambacultural/cultural_event/model/auxiliar_model/auxiliar_data.dart';
import 'package:cochabambacultural/cultural_event/model/cultural_event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cochabambacultural/cultural_event/ui/widgets/cultural_event_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class EventRegistrationForm extends StatefulWidget {
  const EventRegistrationForm({Key? key}) : super(key: key);

  @override
  State<EventRegistrationForm> createState() => _EventRegistrationFormState();
}

class _EventRegistrationFormState extends State<EventRegistrationForm> {
  final _eventName = TextEditingController();
  final _description = TextEditingController();
  final _costEvent = TextEditingController();
  final _transport = TextEditingController();
  final _category = TextEditingController(text: 'Gastronómico');

  final _location = TextEditingController();
  final LatLng _initialLocation = LatLng(-17.3927, -66.1590);
  final List<Marker> _markers = [];

  final _controllerInitialDateTime = TextEditingController();
  final DateTime _initialDateTime = DateTime.now();

  final _controllerEndDateTime = TextEditingController();
  final DateTime _endDateTime = DateTime.now();

  final AuxiliarData auxiliarData = AuxiliarData(
      initialDateTime: DateTime.now(),
      endDateTime: DateTime.now(),
      actualEventType: 1);

  List<String> principalImage = [];
  List<String> secondaryImages = [];

  List<String> tags = [];

  @override
  Widget build(BuildContext context) {
    final eventBloc = BlocProvider.of<CulturalEventBloc>(context);

    return CulturalEventForm(
        eventName: _eventName,
        description: _description,
        costEvent: _costEvent,
        transport: _transport,
        actualEventType: 1,
        category: _category,
        initialLocation: _initialLocation,
        location: _location,
        markers: _markers,
        controllerInitialDateTime: _controllerInitialDateTime,
        initialDateTime: _initialDateTime,
        controllerEndDateTime: _controllerEndDateTime,
        endDateTime: _endDateTime,
        principalImage: principalImage,
        secondaryImages: secondaryImages,
        tags: tags,
        labelButtonForm: 'Crear evento',
        formEvent: () => _createEvent(eventBloc, context),
        auxiliarData: auxiliarData);
  }

  _createEvent(CulturalEventBloc eventBloc, BuildContext context) {
    CulturalEventModel newEvent = CulturalEventModel(
        uid: FirebaseFirestore.instance.collection("events").doc().id,
        eventName: _eventName.text.trim(),
        description: _description.text.trim(),
        initialDateTime: auxiliarData.getInitialDateTime,
        endDateTime: auxiliarData.getEndDateTime,
        costEvent:
            _costEvent.text.isEmpty ? 0 : double.parse(_costEvent.text.trim()),
        transport: _transport.text.isEmpty ? "" : _transport.text.trim(),
        actualEventType: auxiliarData.getActualEventType,
        category: _category.text.trim(),
        address: _location.text.trim(),
        latitude: _initialLocation.latitude,
        longitude: _initialLocation.longitude,
        principalImage: principalImage[0],
        secondaryImages: secondaryImages,
        tags: tags,
        votes: 0,
        starts: 0,
        createdBy: FirebaseAuth.instance.currentUser!.uid);

    eventBloc
        .add(CreatedCulturalEvent(culturalEvent: newEvent, context: context));
  }
}
