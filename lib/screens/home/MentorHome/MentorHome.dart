import 'package:flutter/material.dart';

class MentorHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mentor Home'),
      ),
      body: Center(
        child: Text(
          'Welcome to Mentor Home!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}