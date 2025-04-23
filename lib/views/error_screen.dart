import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3A3F54),
      body: Center(
        child: Text(
          "Error",
          style: TextStyle(fontSize: 35, color: Colors.white),
        ),
      ),
    );
  }
}
