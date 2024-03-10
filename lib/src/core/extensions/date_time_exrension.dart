extension DateTimeExtension on DateTime {
  int get parseToAge {
    final result = DateTime.now().difference(this);
    final age = result.inDays ~/ 365;
    return age;
  }
}
