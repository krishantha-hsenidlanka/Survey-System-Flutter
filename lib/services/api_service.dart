import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:survey_system_mobile/models/user.dart';

class ApiService {
  final String? _baseUrl = dotenv.env['BASE_URL'];

  Future<http.Response> register(User user) {
    return http.post(
      Uri.parse('$_baseUrl/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );
  }

}