import 'package:cochabambacultural/cultural_event/model/cultural_event_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class UpcomingCulturalEvent {
  final _collection = FirebaseFirestore.instance.collection("events");

  Future<List<CulturalEventModel>> getUpcomingCulturalEvents() async {
    DateTime _actualDate = DateTime.now();
    DateTime _start = DateTime(
        _actualDate.year, _actualDate.month, _actualDate.day, 0, 0, 0, 0, 0);
    _actualDate = _actualDate.add(const Duration(days: 6));
    DateTime _end = DateTime(_actualDate.year, _actualDate.month,
        _actualDate.day, 23, 59, 59, 998, 998);

    QuerySnapshot _snapshot = await _collection
        .where('initialDateTime', isGreaterThanOrEqualTo: _start)
        .where('initialDateTime', isLessThanOrEqualTo: _end)
        .orderBy(
          'initialDateTime',
        )
        .get();

    List<CulturalEventModel> _upcomingEvents = _snapshot.docs
        .map((event) => CulturalEventModel.fromMap(event.data()))
        .toList();

    return _upcomingEvents;
  }
}
