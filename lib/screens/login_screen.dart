import 'package:flutter/material.dart';
import 'package:survey_system_mobile/services/auth_service.dart';
import 'package:survey_system_mobile/widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Add form key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'AI Survey',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color.fromARGB(255, 22, 0, 143), const Color.fromARGB(255, 21, 90, 237)], // Add your desired gradient colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: _formKey, 
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, 
            children: <Widget>[
              Text('Login',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              SizedBox(height: 26),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 16.0), 
                child: TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 16.0),
                child: TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 2),
              CustomButton(
                text: 'Login',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final success = await AuthService.login(
                      _usernameController.text,
                      _passwordController.text,
                    );
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Login successful'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pushNamed(context, '/home');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Login failed'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
              ),
              SizedBox(height: 2),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text('Not Registered? Register Here'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
