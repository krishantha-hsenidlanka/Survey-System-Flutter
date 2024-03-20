import 'package:flutter/material.dart';
import 'package:survey_system_mobile/models/survey_response.dart';
import 'package:survey_system_mobile/services/api_service.dart';

class ResponseWidget extends StatelessWidget {
  final SurveyResponse response;

  ResponseWidget({required this.response});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiService().fetchSurveyById(response.surveyId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          var survey = snapshot.data;
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Survey Title: ${survey!.title}'),
                  SizedBox(height: 8),
                  Text('Submitted responses: ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey, fontSize: 14)),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildAnswerItems(response.answers),
              ),
            ),
          );
        }
      },
    );
  }

  List<Widget> _buildAnswerItems(List<Map<String, dynamic>> answers) {
    List<Widget> items = [];
    for (var answer in answers) {
      answer.forEach((key, value) {
        items.add(_buildAnswerItem(key, value));
      });
    }
    return items;
  }

  Widget _buildAnswerItem(String key, dynamic value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$key: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: value is List
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: value
                        .map((item) => Text('- $item'))
                        .toList(),
                  )
                : Text('$value'),
          ),
        ],
      ),
    );
  }
}
