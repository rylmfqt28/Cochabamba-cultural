class GetStringDate {
  String dateToDateFormatString(DateTime date) {
    String dateFormat = '';
    dateFormat += '${date.day}/';
    dateFormat += '${date.month}/';
    dateFormat += '${date.year}  ';
    dateFormat += '${date.hour}:';

    String minute = (date.minute < 10) ? '0${date.minute}' : '${date.minute}';
    dateFormat += minute;
    return dateFormat;
  }
}
