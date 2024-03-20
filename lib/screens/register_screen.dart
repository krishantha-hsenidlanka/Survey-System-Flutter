import 'package:flutter/material.dart';
import 'package:survey_system_mobile/models/user.dart';
import 'package:survey_system_mobile/services/api_service.dart';
import 'package:survey_system_mobile/services/auth_service.dart';
import 'package:survey_system_mobile/widgets/custom_button.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AI Survey',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 22, 0, 143),
                const Color.fromARGB(255, 21, 90, 237)
              ],
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
              Text('Register',
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
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an email';
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
              SizedBox(height: 8),
              CustomButton(
                text: 'Register',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final registerSuccess = await AuthService.register(User(
                      username: _usernameController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                      roles: ['user'],
                    ));
                    if (registerSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Registration successful'),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Registration failed'),
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
