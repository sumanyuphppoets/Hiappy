import 'package:flutter/material.dart';
import 'package:hiappy/core/constants/colors.dart';
import 'package:hiappy/widgets/Invitations/Invitations.dart';

class MeetingsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> invitationData = [
    {
      'title': 'Stress management tips!',
      'speaker': 'Dr. Dinesh Acharjya',
      'dateTime': DateTime.now(),
      'duration': '30 mins',
    },
    {
      'title': 'Dealing with anxiety',
      'speaker': 'Dr. Anita Sharma',
      'dateTime': DateTime.now().add(Duration(days: 1)),
      'duration': '45 mins',
    },
    {
      'title': 'Mindfulness Meditation',
      'speaker': 'Dr. Ramesh Varma',
      'dateTime': DateTime.now().add(Duration(days: 2)),
      'duration': '60 mins',
    },
    {
      'title': 'Overcoming Depression',
      'speaker': 'Dr. Meena Kapoor',
      'dateTime': DateTime.now().add(Duration(days: 3)),
      'duration': '50 mins',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40.0), 
        child: InvitationsList(
          invitations: invitationData.map((data) {
            return Invitation(
              title: data['title'],
              speaker: data['speaker'],
              dateTime: data['dateTime'],
              duration: data['duration'],
              imagePath: 'assets/images/Invitations.png',
              onAccept: () => print('${data['title']} accepted!'),
              onDecline: () => print('${data['title']} declined!'),
              acceptLabel: 'Accept',
              declineLabel: 'Decline',
              acceptColors: [AppColors.royalBlue,AppColors.slateBlue],
              declineColors: [AppColors.royalBlue, AppColors.slateBlue],
              titleStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
