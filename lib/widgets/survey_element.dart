import 'package:flutter/material.dart';

class SurveyElement extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onViewPressed;
  final VoidCallback onEditPressed;
  final VoidCallback onAnalyticsPressed;
  final VoidCallback onDeletePressed;

  SurveyElement({
    required this.icon,
    required this.title,
    required this.onViewPressed,
    required this.onEditPressed,
    required this.onAnalyticsPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon,
                  size: 48, color: const Color.fromARGB(255, 86, 118, 153)),
              SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.remove_red_eye),
                onPressed: onViewPressed,
                color: Colors.blueGrey,
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: onEditPressed,
                color: Colors.blueGrey,
              ),
              IconButton(
                icon: Icon(Icons.analytics),
                onPressed: onAnalyticsPressed,
                color: Colors.blueGrey,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: onDeletePressed,
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
