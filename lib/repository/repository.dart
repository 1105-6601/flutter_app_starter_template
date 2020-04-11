import 'package:flutter_app_starter_template/environments/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Repository {

  static const String AUTH_TOKEN_KEY_NAME = '__token__';

  final String _apiBaseUri = environment['apiBaseUri'];

  Future<http.Response> post(String path, Map<String, dynamic> data) async
  {
    final String body = json.encode(data);

    final http.Response response = await http.post(_apiBaseUri + _normalizePath(path), headers: await _makeHeader(), body: body);

    if (response.statusCode >= 400) {
      throw Exception('Request failed. Code: ${response.statusCode}');
    }

    return response;
  }

  Future<http.Response> get(String path, {Map<String, String> data}) async
  {
    String url = _apiBaseUri + _normalizePath(path);

    final uri = Uri(queryParameters: data);
    if (uri.query != '') {
      url = url + '?' + uri.query;
    }

    final http.Response response = await http.get(url, headers: await _makeHeader());

    if (response.statusCode >= 400) {
      throw Exception('Request failed. Code: ${response.statusCode}');
    }

    return response;
  }

  Future<http.Response> getPlain(String url) async
  {
    final http.Response response = await http.get(url);

    if (response.statusCode >= 400) {
      throw Exception('Request failed. Code: ${response.statusCode}');
    }

    return response;
  }

  Future<Map<String, String>> _makeHeader() async
  {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final base = {'content-type': 'application/json'};

    if (prefs.getString(AUTH_TOKEN_KEY_NAME) != null) {
      base['Authorization'] = 'Bearer ' + prefs.getString(AUTH_TOKEN_KEY_NAME);
    }

    return base;
  }

  String _normalizePath(String path)
  {
    if (path.substring(0, 1) == '/') {
      return path;
    } else {
      return '/' + path;
    }
  }
}