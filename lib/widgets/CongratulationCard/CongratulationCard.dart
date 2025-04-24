import 'package:flutter/material.dart';

class CongratulationCard extends StatelessWidget {
  final String topic;
  final String mentor;

  const CongratulationCard({super.key, required this.topic, required this.mentor});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/Congratulation.png', height: 120),
          SizedBox(height: 20),
          Text("Congratulations!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text("Your session on \"$topic\" with $mentor has been scheduled."),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: Text("Back to Home"),
          ),
        ],
      ),
    );
  }
}
