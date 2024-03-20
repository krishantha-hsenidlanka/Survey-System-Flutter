import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:survey_system_mobile/screens/home_screen.dart';
import 'package:survey_system_mobile/screens/login_screen.dart';
import 'package:survey_system_mobile/screens/profile_screen.dart';
import 'package:survey_system_mobile/screens/register_screen.dart';
import 'package:survey_system_mobile/screens/responses_screen.dart';
import 'package:survey_system_mobile/screens/survey_screen.dart';
import 'package:survey_system_mobile/screens/web_view_screen.dart';
import 'package:survey_system_mobile/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Survey System Mobile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthenticationWrapper(child: HomeScreen()),
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => AuthenticationWrapper(child: HomeScreen()),
        '/register': (context) => RegisterScreen(),
        '/responses': (context) => AuthenticationWrapper(child: ResponseScreen()),
        '/surveys': (context) => AuthenticationWrapper(child: SurveyScreen()), 
        '/profile': (context) => AuthenticationWrapper(child: ProfileScreen()),
      },
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  final Widget child;

  AuthenticationWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: AuthService.isAuthenticated(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // or loading screen
        } else {
          if (snapshot.data == true) {
            return child;
          } else {
            return LoginScreen();
          }
        }
      },
    );
  }
}
