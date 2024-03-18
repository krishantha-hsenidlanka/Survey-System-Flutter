import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 70.0, vertical: 20.0), // Set the desired padding values
      child: Container(
        height: 44.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color.fromARGB(255, 101, 77, 230), Color.fromARGB(255, 39, 0, 255)]),
          borderRadius: BorderRadius.circular(30), // Set border radius
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white, // Set text color to white
                  fontWeight: FontWeight.w700, // Set text font weight to bold
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
