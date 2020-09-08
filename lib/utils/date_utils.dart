String getCustomDate() {
  String _customDate;
  DateTime.now().toString();

  _customDate = DateTime.now().day.toString() +
      "/" +
      DateTime.now().month.toString() +
      "/" +
      DateTime.now().year.toString() +
      " time:" +
      DateTime.now().hour.toString() +
      ":" +
      DateTime.now().minute.toString();

  return _customDate;
}
