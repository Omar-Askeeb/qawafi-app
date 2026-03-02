import 'package:intl/intl.dart';

String formatDateBydMMMYYYY(DateTime dateTime) {
  return DateFormat("d MMM, yyyy").format(dateTime);
}

String formatDateByyyyyMMdd(DateTime dateTime) {
  return DateFormat("yyyy-MM-dd").format(dateTime);
}
