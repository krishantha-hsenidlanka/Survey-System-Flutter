import 'package:flutter/material.dart';
import 'package:survey_system_mobile/widgets/app_layout.dart';
import 'package:survey_system_mobile/widgets/survey_element.dart';

class SurveySreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: 'My Surveys',
      backButton: false,
      currentIndex: 1, 
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/home');
            break;
          case 2:
            Navigator.pushNamed(context, '/responses');
            break;
          case 3:
            Navigator.pushNamed(context, '/profile');
            break;
        }
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SurveyElement(
              icon: Icons.description,
              title: 'Survey Title',
              onViewPressed: () {
                // Handle view button pressed
              },
              onEditPressed: () {
                // Handle edit button pressed
              },
              onAnalyticsPressed: () {
                // Handle analytics button pressed
              },
              onDeletePressed: () {
                // Handle delete button pressed
              },
            ),
            SurveyElement(
              icon: Icons.description,
              title: 'Survey Title',
              onViewPressed: () {
                // Handle view button pressed
              },
              onEditPressed: () {
                // Handle edit button pressed
              },
              onAnalyticsPressed: () {
                // Handle analytics button pressed
              },
              onDeletePressed: () {
                // Handle delete button pressed
              },
            ),
          ],
        ),
      ),
    );
  }
}
