import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  int get parseToAge {
    final result = DateTime.now().difference(this);
    final age = result.inDays ~/ 365;
    return age;
  }

  String get formatToShow {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    return dateFormat.format(this);
  }
}
