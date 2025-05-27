import 'package:intl/intl.dart';

class Formater {
  static String numberFormatToURL(int number) {
    final formater = NumberFormat('000');
    return formater.format(number);
  }

  static String timeStamp(DateTime dateTime) {
    return DateFormat('d MMMM y,', 'id').addPattern('HH:mm').format(dateTime);
  }
}
