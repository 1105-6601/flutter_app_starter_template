import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter_app_starter_template/repository/repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class DeviceUtil
{
  static const String _DEVICE_ID_FILENAME = 'deviceid';

  static Future<String> resolveDocumentDir() async
  {
    return (await getApplicationDocumentsDirectory()).path;
  }

  static Future<String> resolveDeviceId() async
  {
    final documentDir = await resolveDocumentDir();
    final deviceIdFile = File('$documentDir/$_DEVICE_ID_FILENAME');

    if (!await deviceIdFile.exists()) {
      await deviceIdFile.create(recursive: true);
    }

    String deviceId = await deviceIdFile.readAsString();

    if (deviceId == '') {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.androidId;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
        deviceId = iosDeviceInfo.identifierForVendor;
      }

      // If cannot resolve device id, generate UUID manually then store to document dir.
      if (deviceId == '') {
        final uuid = Uuid();
        deviceId = uuid.v4();
      }

      await deviceIdFile.writeAsString(deviceId);
    }

    return deviceId;
  }

  static Future<SharedPreferences> getSharedPreferences() async
  {
    return await SharedPreferences.getInstance();
  }

  static Future<void> saveNetworkImage(String url, String filename) async
  {
    final repo = Repository();
    final docDir = await resolveDocumentDir();
    try {
      final imageResponse = await repo.getPlain(url);
      final file = await File('$docDir/$filename').create(recursive: true);
      await file.writeAsBytes(imageResponse.bodyBytes);
    } catch (e) {
      throw e;
    }
  }
}