import 'package:flutter_app_starter_template/repository/repository.dart';
import 'package:flutter_app_starter_template/storage/user-data.storage.dart';
import 'package:flutter_app_starter_template/util/device-util.dart';

class AuthService
{
  static Future<bool> hasAuthToken() async
  {
    final pref = await DeviceUtil.getSharedPreferences();
    final token = pref.getString(Repository.AUTH_TOKEN_KEY_NAME);

    return token != null;
  }

  static Future<void> logOut() async
  {
    final pref = await DeviceUtil.getSharedPreferences();

    await pref.remove(Repository.AUTH_TOKEN_KEY_NAME);
    await UserDataStorage.clear();
  }

  static Future<void> login(String token) async
  {
    final pref = await DeviceUtil.getSharedPreferences();

    await pref.setString(Repository.AUTH_TOKEN_KEY_NAME, token);
  }
}
