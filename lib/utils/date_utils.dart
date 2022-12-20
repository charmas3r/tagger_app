import 'package:intl/intl.dart';

String formatDate(DateTime? dateTime) {
  return dateTime != null ? DateFormat.yMMMMd().format(dateTime) : "";
}