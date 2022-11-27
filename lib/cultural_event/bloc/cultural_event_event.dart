part of 'cultural_event_bloc.dart';

@immutable
abstract class CulturalEventEvent {}

class CreatedCulturalEvent extends CulturalEventEvent {
  final CulturalEventModel culturalEvent;
  final BuildContext context;

  CreatedCulturalEvent({required this.culturalEvent, required this.context});
}

class SetStateCulturalEvent extends CulturalEventEvent {
  final CulturalEventModel culturalEvent;

  SetStateCulturalEvent({required this.culturalEvent});
}

class UpdateCulturalEvent extends CulturalEventEvent {
  final CulturalEventModel culturalEvent;
  final BuildContext context;

  UpdateCulturalEvent({required this.culturalEvent, required this.context});
}
