import 'package:flutter/material.dart';

class ZoneSessionScreen extends StatelessWidget {
  const ZoneSessionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zone Session'),
      ),
      body: const Center(
        child: Text('Welcome to Zone Session Screen!'),
      ),
    );
  }
}