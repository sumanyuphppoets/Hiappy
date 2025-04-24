import 'package:flutter/material.dart';

class ProfileSessionScreen extends StatelessWidget {
  const ProfileSessionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Session'),
      ),
      body: const Center(
        child: Text('Welcome to Profile Session Screen!'),
      ),
    );
  }
}