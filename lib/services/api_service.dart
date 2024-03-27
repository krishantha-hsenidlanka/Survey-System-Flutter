import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:survey_system_mobile/models/survey.dart';
import 'package:survey_system_mobile/models/survey_response.dart';
import 'package:survey_system_mobile/models/user.dart';
import 'package:survey_system_mobile/screens/web_view_screen.dart';
import 'package:survey_system_mobile/services/auth_service.dart';

class ApiService {
  final String _baseUrl = dotenv.env['BASE_URL']!;

  Future<List<Survey>> fetchSurveys({int page = 0, int size = 5}) async {
    final url = Uri.parse('$_baseUrl/surveys/user?page=$page&size=$size');

    try {
      final token = await AuthService.getToken();

      final response = await http.get(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> surveyList = jsonResponse['content'];

        return surveyList.map((json) => Survey.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load surveys');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  Future<void> deleteSurvey(String surveyId) async {
    final url = Uri.parse('$_baseUrl/surveys/$surveyId');

    try {
      final token = await AuthService.getToken();

      final response = await http.delete(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to delete survey');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  Future<List<SurveyResponse>> fetchResponses(
      {int page = 0, int size = 10}) async {
    final url =
        Uri.parse('$_baseUrl/responses/byCurrentUser?page=$page&size=$size');

    try {
      final token = await AuthService.getToken();

      final response = await http.get(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> responseList = jsonResponse['content'];

        return responseList
            .map((json) => SurveyResponse.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load responses');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  Future<Survey> fetchSurveyById(String surveyId) async {
    final url = Uri.parse('$_baseUrl/surveys/$surveyId');

    try {
      final token = await AuthService.getToken();

      final response = await http.get(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return Survey.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load survey');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  Future<User> fetchUserDetails() async {
    final url = Uri.parse('$_baseUrl/auth/user-details');

    try {
      final token = await AuthService.getToken();

      final response = await http.get(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return User.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load user details');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to connect to the server');
    }
  }

  Future<String> createSurvey(Map<String, dynamic> data) async {
    final url = Uri.parse('$_baseUrl/surveys');

    try {
      final token = await AuthService.getToken();

      final response = await http.post(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', 
        },
        body: jsonEncode(data),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse['id'];
      } else {
        throw Exception('Failed to create survey');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  Future<String> createSurveyWithSampleData() async {
    const newSurveyData = {
      'title': 'New',
      'description': 'New',
      'pages': [
        {
          'name': 'Name',
          'elements': [
            {
              'name': 'FirstName',
              'title': 'Enter your first name:',
              'type': 'text',
            },
            {
              'name': 'LastName',
              'title': 'Enter your last name:',
              'type': 'text',
            },
          ],
        },
      ],
    };
    try {
      return await createSurvey(newSurveyData);
    } catch (e) {
      throw Exception('Failed to create survey');
    }
  }
  
  Future<String> generateSurvey(String data) async {
    final url = Uri.parse('$_baseUrl/surveys/generate-survey');

    try {
      final token = await AuthService.getToken();

      final response = await http.post(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );

      print(response.body);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse['id'];
      } else {
        throw Exception('Failed to generate survey');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }
  
}
