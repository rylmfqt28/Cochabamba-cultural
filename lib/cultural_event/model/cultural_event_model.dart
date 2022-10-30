import 'package:cochabambacultural/cultural_event/model/comment_model.dart';

class CulturalEventModel {
  String? uid;
  String? eventName;
  String? description;
  DateTime? initialDateTime;
  DateTime? endDateTime;
  double? costEvent;
  String? transport;
  int? actualEventType;
  String? category;
  String? address;
  double? latitude;
  double? longitude;
  String? principalImage;
  List<String>? secondaryImages;
  List<String>? tags;
  int? votes;
  double? starts;
  String? createdBy;

  CulturalEventModel(
      {this.uid,
      this.eventName,
      this.description,
      this.initialDateTime,
      this.endDateTime,
      this.costEvent,
      this.transport,
      this.actualEventType,
      this.category,
      this.address,
      this.latitude,
      this.longitude,
      this.principalImage,
      this.secondaryImages,
      this.tags,
      this.votes,
      this.starts,
      this.createdBy});

  factory CulturalEventModel.fromMap(map) {
    return CulturalEventModel(
        uid: map["uid"],
        eventName: map["eventName"],
        description: map["description"],
        initialDateTime: map["initialDateTime"],
        endDateTime: map["endDateTime"],
        costEvent: map["costEvent"],
        transport: map["transport"],
        actualEventType: map["actualEventType"],
        category: map["category"],
        address: map["address"],
        latitude: map["latitude"],
        longitude: map["longitude"],
        principalImage: map["principalImage"],
        secondaryImages: map["secondaryImages"],
        tags: map["tags"],
        votes: map["votes"],
        starts: map["starts"],
        createdBy: map["createdBy"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "eventName": eventName,
      "description": description,
      "initialDateTime": initialDateTime,
      "endDateTime": endDateTime,
      "costEvent": costEvent,
      "transport": transport,
      "actualEventType": actualEventType,
      "category": category,
      "address": address,
      "latitude": latitude,
      "longitude": longitude,
      "principalImage": principalImage,
      "secondaryImages": secondaryImages,
      "tags": tags,
      "votes": votes,
      "starts": starts,
      "createdBy": createdBy
    };
  }

  copyWith({
    String? uid,
    String? eventName,
    String? description,
    DateTime? initialDateTime,
    DateTime? endDateTime,
    double? costEvent,
    String? transport,
    int? actualEventType,
    String? category,
    String? address,
    double? latitude,
    double? longitude,
    String? principalImage,
    List<String>? secondaryImages,
    List<String>? tags,
    int? votes,
    double? starts,
    String? createdBy,
  }) =>
      CulturalEventModel(
          uid: uid ?? this.uid,
          eventName: eventName ?? this.eventName,
          description: description ?? this.description,
          initialDateTime: initialDateTime ?? this.initialDateTime,
          endDateTime: endDateTime ?? this.endDateTime,
          costEvent: costEvent ?? this.costEvent,
          transport: transport ?? this.transport,
          actualEventType: actualEventType ?? this.actualEventType,
          category: category ?? this.category,
          address: address ?? this.address,
          latitude: latitude ?? this.latitude,
          longitude: longitude ?? this.longitude,
          principalImage: principalImage ?? this.principalImage,
          secondaryImages: secondaryImages ?? this.secondaryImages,
          tags: tags ?? this.tags,
          votes: votes ?? this.votes,
          starts: starts ?? this.starts,
          createdBy: createdBy ?? this.createdBy);
}
