import 'package:flutter/material.dart';
import 'package:survey_system_mobile/models/user.dart';
import 'package:survey_system_mobile/screens/web_view_screen.dart';
import 'package:survey_system_mobile/services/api_service.dart';
import 'package:survey_system_mobile/widgets/app_layout.dart';
import 'package:survey_system_mobile/widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: 'AI Survey',
      backButton: false,
      currentIndex: 0,
      onTap: (index) {
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
      child: FutureBuilder<User>(
        future: apiService.fetchUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            User? user = snapshot.data;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hello ${user!.username}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Welcome to the AI Survey!',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  CustomButton(
                    onPressed: () async {
                     try{
                       String responseId =
                          await apiService.createSurveyWithSampleData();
                      String url =
                          'https://aisurvey.netlify.app/survey/edit/$responseId';
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Survey created successfully!'), backgroundColor: Colors.green,
                      ));
                      navigateToWebView(context, url);
                     } catch (e) {
                       print('Error: $e');
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                         content: Text('Error creating survey!'), backgroundColor: Colors.red,
                       ));
                     }
                    },
                    text: 'New Survey',
                  ),
                  CustomButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          TextEditingController promptController =
                              TextEditingController();
                          return AlertDialog(
                            title: Text('Prompt'),
                            content: TextField(
                              controller: promptController,
                              decoration: InputDecoration(
                                  hintText: 'Enter your prompt'),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () async {
                                  String prompt = promptController.text;
                                  print('Prompt: $prompt');
                                  try{
                                    String responseId =
                                      await apiService.generateSurvey(prompt);
                                  String url =
                                      'https://aisurvey.netlify.app/survey/edit/$responseId';
                                      
                                  navigateToWebView(context, url);
                                  } catch (e) {
                                    print('Error: $e');
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text('Error generating survey!'), backgroundColor: Colors.red,
                                    ));
                                  }
                                },
                                child: Text('OK'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    text: 'AI Generate',
                  ),
                  ElevatedButton(
                      onPressed: () => {
                        navigateToWebView(context, 'https://aisurvey.netlify.app')

                      }, child: Text('Try Web App')),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error fetching user details: ${snapshot.error}',
                style: TextStyle(
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
