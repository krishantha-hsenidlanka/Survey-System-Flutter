import 'package:flutter/material.dart';
import 'package:survey_system_mobile/main.dart';
import 'package:survey_system_mobile/widgets/app_layout.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: 'Home',
      backButton: false,
      currentIndex: 0, // Home screen index
      onTap: (index) {
        // Handle navigation to different screens
        switch (index) {
          case 1:
            Navigator.pushNamed(context, '/surveys');
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
            Text('Welcome to Home Screen!'),
            ElevatedButton(
              onPressed: () => navigateToWebView(context, 'https://google.com'),
              child: Text('Go to WebView'),
            ),
          ],
        ),
      ),
    );
  }
}
