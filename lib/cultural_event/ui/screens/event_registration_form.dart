import 'package:flutter/material.dart';

import 'package:cochabambacultural/cultural_event/ui/widgets/cultural_event_form.dart';

class EventRegistrationForm extends StatefulWidget {
  const EventRegistrationForm({Key? key}) : super(key: key);

  @override
  State<EventRegistrationForm> createState() => _EventRegistrationFormState();
}

class _EventRegistrationFormState extends State<EventRegistrationForm> {
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  final _eventName = TextEditingController();
  final _description = TextEditingController();
  final _costEvent = TextEditingController();
  final _transport = TextEditingController();
  final _category = TextEditingController(text: 'Gastronómico');

  final _controllerInitialDateTime = TextEditingController();
  final DateTime _initialDateTime = DateTime.now();

  List<String> principalImage = [];
  List<String> secondaryImages = [];

  List<String> tags = [];

  @override
  Widget build(BuildContext context) {
    return CulturalEventForm(
        keyForm: _keyForm,
        eventName: _eventName,
        description: _description,
        costEvent: _costEvent,
        transport: _transport,
        category: _category,
        controllerInitialDateTime: _controllerInitialDateTime,
        initialDateTime: _initialDateTime,
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
