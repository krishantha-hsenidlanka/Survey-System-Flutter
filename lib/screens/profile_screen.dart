import 'package:flutter/material.dart';
import 'package:survey_system_mobile/models/user.dart';
import 'package:survey_system_mobile/widgets/app_layout.dart';
import 'package:survey_system_mobile/services/api_service.dart';
import 'package:survey_system_mobile/widgets/change_password.dart';

class ProfileScreen extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: 'My Profile',
      backButton: false,
      currentIndex: 3, 
      onTap: (index) {
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
        }
      },
      child: FutureBuilder<User>(
        future: apiService.fetchUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            User? user = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 26),
                  Icon(Icons.account_circle,
                      size: 80, color: Color.fromARGB(255, 36, 3, 112)),
                  SizedBox(height: 16),
                  Text(
                    'User Name: ${user!.username}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Email: ${user.email}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 16),
                  ChangePasswordWidget(),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            print('Error fetching user details: ${snapshot.error}');
            return Center(
              child: Text(
                'Error fetching user details',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            );
          } else {
            return Center(
              child: Text('No user data available'),
            );
          }
        },
      ),
    );
  }
}
