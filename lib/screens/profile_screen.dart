import 'package:flutter/material.dart';
import 'package:survey_system_mobile/widgets/app_layout.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: 'My Profile',
      backButton: false,
      currentIndex: 3, // Responses screen index
      onTap: (index) {
        // Handle navigation to different screens
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/home');
            break;
          case 1:
            Navigator.pushNamed(context, '/surveys');
            break;
          case 2:
            Navigator.pushNamed(context, '/responses');
            break;
          // Add more cases as needed
        }
      },
      child: Center(
        child: Text('Welcome to Profile!'),
      ),
    );
  }
}
