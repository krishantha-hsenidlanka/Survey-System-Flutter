import 'package:flutter/material.dart';
import 'package:survey_system_mobile/models/survey_response.dart';
import 'package:survey_system_mobile/widgets/app_layout.dart';
import 'package:survey_system_mobile/services/api_service.dart';
import 'package:survey_system_mobile/widgets/response_widget.dart';

class ResponseScreen extends StatefulWidget {
  @override
  _ResponseScreenState createState() => _ResponseScreenState();
}

class _ResponseScreenState extends State<ResponseScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<SurveyResponse>> _futureResponses;

  @override
  void initState() {
    super.initState();
    _futureResponses = _apiService.fetchResponses();
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: 'My Responses',
      backButton: false,
      currentIndex: 2, 
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/home');
            break;
          case 1:
            Navigator.pushNamed(context, '/surveys');
            break;
          case 3:
            Navigator.pushNamed(context, '/profile');
            break;
        }
      },
      child: FutureBuilder<List<SurveyResponse>>(
        future: _futureResponses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final responses = snapshot.data!;
            return ListView.builder(
              itemCount: responses.length,
              itemBuilder: (context, index) {
                return ResponseWidget(response: responses[index]);
              },
            );
          }
        },
      ),
    );
  }
}
