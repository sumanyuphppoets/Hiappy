import 'package:flutter/material.dart';

class DoctorHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Home'),
      ),
      body: Center(
        child: Text(
          'Welcome to Doctor Home Screen!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}