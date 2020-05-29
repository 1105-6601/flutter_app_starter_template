import 'dart:io';
import 'package:flutter_app_starter_template/repository/repository.dart';
import 'package:image/image.dart';
import 'package:device_info/device_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

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

  static Future<String> saveNetworkImage(String url, String filename) async
  {
    final repo = Repository();
    final docDir = await resolveDocumentDir();

    String savePath;

    try {
      final imageResponse = await repo.getPlain(url);
      final String ext = await detectImageExtension(imageResponse);

      savePath = '$docDir/$filename.$ext';

      final file = await File(savePath).create(recursive: true);
      await file.writeAsBytes(imageResponse.bodyBytes);
    } catch (e) {
      throw e;
    }

    return savePath;
  }

  static Future<String> createThumbnail(String url, String filename) async
  {
    final repo = Repository();
    final docDir = await resolveDocumentDir();

    http.Response imageResponse;

    try {
      imageResponse = await repo.getPlain(url);
    } catch (e) {
      throw e;
    }

    final String ext = await detectImageExtension(imageResponse);
    final savePath = '$docDir/thumbnails/$filename.$ext';
    final image = decodeImage(imageResponse.bodyBytes);
    final thumbnail = copyResize(image, width: 200);
    final file = await File(savePath).create(recursive: true);

    switch (ext) {
      case 'png':
        file.writeAsBytesSync(encodePng(thumbnail));
        break;
      case 'gif':
        file.writeAsBytesSync(encodeGif(thumbnail));
        break;
      case 'jpg':
      default:
        file.writeAsBytesSync(encodeJpg(thumbnail));
        break;
    }

    return savePath;
  }

  static Future<String> detectImageExtension(http.Response imageResponse) async
  {
    String ext;

    switch (imageResponse.headers['content-type']) {
      case 'image/png':
        ext = 'png';
        break;
      case 'image/gif':
        ext = 'gif';
        break;
      case 'image/jpeg':
      default:
        ext = 'jpg';
        break;
    }

    return ext;
  }

  static void deleteFile(String path)
  {
    final file = File(path);
    if (!file.existsSync()) {
      return;
    }

    file.deleteSync();
  }
}
