import 'package:flutter/material.dart';

class SessionHistory extends StatelessWidget {
  const SessionHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Session history will be displayed here.'),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).maybePop();  // Go back to the previous page
                },
                child: Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
