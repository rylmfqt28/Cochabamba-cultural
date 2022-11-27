import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:latlong2/latlong.dart';

import 'package:flutter_map/flutter_map.dart';

import 'package:cochabambacultural/cultural_event/ui/widgets/cultural_event_form.dart';
import 'package:cochabambacultural/cultural_event/model/auxiliar_model/auxiliar_data.dart';
import 'package:cochabambacultural/cultural_event/model/cultural_event_model.dart';
import 'package:cochabambacultural/cultural_event/bloc/cultural_event_bloc.dart';
import 'package:cochabambacultural/cultural_event/utils/new_marker.dart';

class EventEditForm extends StatefulWidget {
  const EventEditForm({Key? key}) : super(key: key);

  @override
  State<EventEditForm> createState() => _EventEditFormState();
}

class _EventEditFormState extends State<EventEditForm> {
  final _eventName = TextEditingController();
  final _description = TextEditingController();
  final _costEvent = TextEditingController();
  final _transport = TextEditingController();
  final _category = TextEditingController(text: 'Gastronómico');

  final _location = TextEditingController();
  final LatLng _initialLocation = LatLng(-17.3927, -66.1590);
  final List<Marker> _markers = [];

  final _controllerInitialDateTime = TextEditingController();

  final _controllerEndDateTime = TextEditingController();

  final AuxiliarData auxiliarData = AuxiliarData(
      initialDateTime: DateTime.now(),
      endDateTime: DateTime.now(),
      actualEventType: 1);

  List<String> principalImage = [];
  List<String> secondaryImages = [];

  List<String> tags = [];

  NewMarker newMarker = NewMarker();

  @override
  Widget build(BuildContext context) {
    final eventState = BlocProvider.of<CulturalEventBloc>(context).state;

    _setStateEventEditForm(eventState.event!, context);

    return CulturalEventForm(
        eventName: _eventName,
        description: _description,
        costEvent: _costEvent,
        transport: _transport,
        actualEventType: auxiliarData.actualEventType!,
        category: _category,
        initialLocation: _initialLocation,
        location: _location,
        markers: _markers,
        controllerInitialDateTime: _controllerInitialDateTime,
        initialDateTime: DateTime.now(),
        controllerEndDateTime: _controllerEndDateTime,
        endDateTime: DateTime.now(),
        principalImage: principalImage,
        secondaryImages: secondaryImages,
        tags: tags,
        labelButtonForm: "Guardar Cambios",
        formEvent: () => _updateEvent(
            BlocProvider.of<CulturalEventBloc>(context),
            eventState.event!,
            context),
        auxiliarData: auxiliarData);
  }

  void _setStateEventEditForm(
      CulturalEventModel culturalEvent, BuildContext context) {
    setState(() {
      _eventName.text = culturalEvent.eventName!;
      _description.text = culturalEvent.description!;
      _costEvent.text = culturalEvent.costEvent!.toString();
      _transport.text = culturalEvent.transport!;
      _category.text = culturalEvent.category!;
      _location.text = culturalEvent.address!;
      _initialLocation.latitude = culturalEvent.latitude!;
      _initialLocation.longitude = culturalEvent.longitude!;
      _markers.add(newMarker.createdMarker(
          LatLng(culturalEvent.latitude!, culturalEvent.longitude!), context));
      auxiliarData.initialDateTime = culturalEvent.initialDateTime!;
      _controllerInitialDateTime.text =
          "Fecha: ${culturalEvent.initialDateTime!.day}-${culturalEvent.initialDateTime!.month}-${culturalEvent.initialDateTime!.year}   Hora: ${culturalEvent.initialDateTime!.hour}:${culturalEvent.initialDateTime!.minute}";
      auxiliarData.endDateTime = culturalEvent.endDateTime!;
      _controllerEndDateTime.text =
          "Fecha: ${culturalEvent.endDateTime!.day}-${culturalEvent.endDateTime!.month}-${culturalEvent.endDateTime!.year}   Hora: ${culturalEvent.endDateTime!.hour}:${culturalEvent.endDateTime!.minute}";
      auxiliarData.actualEventType = culturalEvent.actualEventType!;
      principalImage.add(culturalEvent.principalImage!);
      secondaryImages = culturalEvent.secondaryImages!;
      tags = culturalEvent.tags!;
    });
  }

  _updateEvent(CulturalEventBloc eventBloc, CulturalEventModel culturalEvent,
      BuildContext context) {
    CulturalEventModel updateEvent = CulturalEventModel(
        uid: culturalEvent.uid!,
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
        votes: culturalEvent.votes!,
        starts: culturalEvent.starts!,
        createdBy: culturalEvent.createdBy!);

    eventBloc
        .add(UpdateCulturalEvent(culturalEvent: updateEvent, context: context));
  }
}
