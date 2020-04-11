import 'package:intl/date_symbol_data_local.dart';
import "package:intl/intl.dart";

class DateUtil
{
  static String dateFormat(String dateString, {String format = 'yyyy/MM/dd'})
  {
    initializeDateFormatting('ja_JP');

    DateTime datetime = DateTime.parse(dateString);

    var formatter = new DateFormat(format, 'ja_JP');
    var formatted = formatter.format(datetime);

    return formatted;
  }
}