part of 'cultural_event_bloc.dart';

@immutable
abstract class CulturalEventEvent {}

class CreatedCulturalEvent extends CulturalEventEvent {
  final CulturalEventModel event;

  CreatedCulturalEvent({required this.event});
}
