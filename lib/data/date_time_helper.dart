class DateTimeHelper {
  String convertDateTimeToString(DateTime dateTime) {
    // Converting Days
    String day = dateTime.day.toString();
    if (day.length == 1) {
      day = '0$day';
    }

    // Converting Months
    String month = dateTime.month.toString();
    if (month.length == 1) {
      month = '0$month';
    }

    // Converting Years
    String year = dateTime.year.toString();

    // Combination
    String yyyymmdd = year + month + day;
    return yyyymmdd;
  }
}
