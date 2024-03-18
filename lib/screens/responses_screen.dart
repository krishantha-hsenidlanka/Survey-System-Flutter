import 'package:flutter/material.dart';
import 'package:survey_system_mobile/widgets/app_layout.dart';

class ResponseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: 'My Responses',
      backButton: false,
      currentIndex: 2, // Responses screen index
      onTap: (index) {
        // Handle navigation to different screens
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
      child: Center(
        child: Text('Welcome to Responses!'),
      ),
    );
  }
}
