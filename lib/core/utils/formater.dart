import 'package:intl/intl.dart';

class Formater {
  static String numberFormatToURL(int number) {
    final formater = NumberFormat('000');
    return formater.format(number);
  }
}
