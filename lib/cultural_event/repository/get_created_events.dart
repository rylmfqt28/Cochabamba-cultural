import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cochabambacultural/cultural_event/model/cultural_event_model.dart';

class GetCreatedEvents {
  final _collection = FirebaseFirestore.instance.collection("events");

  Future<List<CulturalEventModel>> getMyEvents(String uid) async {
    QuerySnapshot _snapshot =
        await _collection.where("createdBy", isEqualTo: uid).get();
    //.orderBy("eventName", descending: false)

    List<CulturalEventModel> _myEvents = _snapshot.docs
        .map((event) => CulturalEventModel.fromMap(event.data()))
        .toList();

    return _myEvents;
  }
}
