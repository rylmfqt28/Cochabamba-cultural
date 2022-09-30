import 'package:flutter/material.dart';

import 'package:cochabambacultural/cultural_event/ui/widgets/cultural_event_form.dart';

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

  List<String> principalImage = [];
  List<String> secondaryImages = [];

  List<String> tags = [];

  @override
  Widget build(BuildContext context) {
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
        formEvent: () => _createEvent());
  }

  _createEvent() {
    return;
  }
}
