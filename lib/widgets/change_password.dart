import 'package:flutter/material.dart';
import 'package:survey_system_mobile/services/api_service.dart';
import 'package:survey_system_mobile/services/auth_service.dart';
import 'package:survey_system_mobile/widgets/custom_button.dart';

class ChangePasswordWidget extends StatelessWidget {
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  Future<void> _changePassword(BuildContext context) async {
    String currentPassword = currentPasswordController.text;
    String newPassword = newPasswordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    bool success = await AuthService.changePassword(currentPassword, newPassword);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password changed successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to change password'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Change Password',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: currentPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your current password',
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: newPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your new password',
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Confirm your new password',
            ),
          ),
          SizedBox(height: 16),
          CustomButton(
            onPressed: () => _changePassword(context),
            text: 'Change Password',
          ),
        ],
      ),
    );
  }
}
