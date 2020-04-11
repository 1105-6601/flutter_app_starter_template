import 'package:flutter_app_starter_template/repository/repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserRepository extends Repository
{
  Future<Map<String, dynamic>> login(String email, String password) async
  {
    final http.Response response = await post('/v1/user/login', {'email': email, 'password': password});

    final Map<String, dynamic> decoded = json.decode(response.body);

    return decoded;
  }

  Future<Map<String, dynamic>> isValid() async
  {
    final http.Response response = await get('/v1/token/is_valid');

    final Map<String, dynamic> decoded = json.decode(response.body);

    return decoded;
  }
}