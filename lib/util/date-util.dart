import 'package:intl/date_symbol_data_local.dart';
import "package:intl/intl.dart";

class DateUtil
{
  static String dateFormatFromString(String dateString, {String format = 'yyyy/MM/dd'})
  {
    initializeDateFormatting('ja_JP');

    DateTime dateTime = DateTime.parse(dateString);

    return dateFormat(dateTime, format: format);
  }

  static String elapsedTime(DateTime dateTime)
  {
    initializeDateFormatting('ja_JP');

    final now = DateTime.now();
    final duration = now.difference(dateTime);

    if (duration.inSeconds < 60) {
      return '${duration.inSeconds}秒前';
    } else if (duration.inMinutes < 60) {
      return '${duration.inMinutes}分前';
    } else if (duration.inHours < 24) {
      return '${duration.inHours}時間前';
    } else if (duration.inDays == 1) {
      return '昨日';
    } else if (duration.inDays < 7) {
      return '${duration.inDays}日前';
    } else if (duration.inDays < 30) {
      return '${(duration.inDays / 7).floor()}週間前';
    } else if (duration.inDays < 365) {
      return '${(duration.inDays / 30).floor()}ヶ月前';
    } else {
      return dateFormat(dateTime);
    }
  }

  static String dateFormat(DateTime dateTime, {String format = 'yyyy/MM/dd'})
  {
    initializeDateFormatting('ja_JP');

    var formatter = new DateFormat(format, 'ja_JP');
    var formatted = formatter.format(dateTime);

    return formatted;
  }
}