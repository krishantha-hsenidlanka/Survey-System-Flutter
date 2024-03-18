import 'package:flutter/material.dart';
import 'package:survey_system_mobile/services/auth_service.dart';
import 'bottom_navigation.dart';

class AppLayout extends StatelessWidget {
  final Widget child;
  final String title;
  final bool backButton;
  final int currentIndex;
  final Function(int) onTap;

  const AppLayout({
    Key? key,
    required this.child,
    this.title = '',
    this.backButton = true,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => backButton,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          automaticallyImplyLeading: backButton,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color.fromARGB(255, 22, 0, 143), const Color.fromARGB(255, 21, 90, 237)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              color: Colors.white,
              onPressed: () {
                AuthService.logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<bool>(
            future: AuthService.isAuthenticated(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error occurred!'));
              } else if (snapshot.data == true) {
                return child;
              } else {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  Navigator.pushReplacementNamed(context, '/login');
                });
                return Container();
              }
            },
          ),
        ),
        bottomNavigationBar: BottomNavigation(
          currentIndex: currentIndex,
          onTap: onTap,
        ),
      ),
    );
  }
}
