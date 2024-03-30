extension DateTimeExtensions on DateTime {
  String getHours() {
    return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
  }
}
