import 'package:flutter/material.dart';

class CreateSessionScreen extends StatelessWidget {
  const CreateSessionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Session'),
      ),
      body: Center(
        child: const Text('Create Session Screen'),
      ),
    );
  }
}