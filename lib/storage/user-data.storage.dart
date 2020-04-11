import 'package:flutter_app_starter_template/util/device-util.dart';
import 'dart:convert';

class UserDataStorage
{
  static const STORAGE_KEY = '__user_data__';

  static Future<dynamic> set(Map<String, dynamic> data) async
  {
    final pref = await DeviceUtil.getSharedPreferences();

    await pref.setString(STORAGE_KEY, json.encode(data));
  }

  static Future<dynamic> get({String key}) async
  {
    final pref = await DeviceUtil.getSharedPreferences();

    final value = pref.getString(STORAGE_KEY);

    final decoded = json.decode(value);

    if (key != null) {
      return decoded[key];
    } else {
      return decoded;
    }
  }

  static Future<dynamic> clear() async
  {
    final pref = await DeviceUtil.getSharedPreferences();

    await pref.remove(STORAGE_KEY);
  }
}