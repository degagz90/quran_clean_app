import 'package:intl/intl.dart';

class Formater {
  static String numberFormatToURL(int number) {
    final formater = NumberFormat('000');
    return formater.format(number);
  }

  static String tanggalToUrl(DateTime dateTime) {
    return DateFormat("y/M/d").format(dateTime);
  }

  static String timeStamp(DateTime dateTime) {
    return DateFormat('d MMMM y,', 'id').addPattern('HH:mm').format(dateTime);
  }

  static String hari(DateTime dateTime) {
    return DateFormat('EEEE', 'id').format(dateTime);
  }

  static String tanggal(DateTime dateTime) {
    return DateFormat('d MMMM y,', 'id').format(dateTime);
  }

  static String jam(DateTime dateTime) {
    return DateFormat('HH:mm', 'id').format(dateTime);
  }
}
