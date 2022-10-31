part of 'cultural_event_bloc.dart';

@immutable
abstract class CulturalEventState {
  final bool existEvent;
  final CulturalEventModel? event;

  const CulturalEventState({this.existEvent = false, this.event});
}

class CulturalEventInitialState extends CulturalEventState {
  const CulturalEventInitialState() : super(existEvent: false, event: null);
}

class CulturalEventSetState extends CulturalEventState {
  final CulturalEventModel newEvent;

  const CulturalEventSetState({required this.newEvent})
      : super(existEvent: true, event: newEvent);
}
