class AuxiliarData {
  DateTime? initialDateTime;
  DateTime? endDateTime;
  int? actualEventType;

  AuxiliarData({this.initialDateTime, this.endDateTime, this.actualEventType});

  DateTime get getInitialDateTime => initialDateTime!;
  set setInitialDateTime(DateTime newDate) {
    initialDateTime = newDate;
  }

  DateTime get getEndDateTime => endDateTime!;
  set setEndDateTime(DateTime newDate) {
    endDateTime = newDate;
  }

  int get getActualEventType => actualEventType!;
  set setActualEventType(int newActualEventType) {
    actualEventType = newActualEventType;
  }
}
