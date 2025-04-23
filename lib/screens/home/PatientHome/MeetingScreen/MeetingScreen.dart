import 'package:flutter/material.dart';
import 'package:hiappy/core/constants/colors.dart';
import 'package:hiappy/widgets/CustomAppbar/PatientCustomAppbar.dart';
import 'package:hiappy/widgets/Sessionscard/SessionsCard.dart';
import 'package:hiappy/widgets/UpcomingMeetings/UpcomingMeetings.dart';


// Placeholder for meeting data
final Meeting meeting = Meeting(
  topic: "Topic",
  mentor: "Abhijeet Patel",
  imagePath: "assets/images/Sessionimg.png",
  dateTime: DateTime(2024, 7, 20, 12, 45),
  duration: "30-45 min",
  platform: "Via Zoom", // ✅ Corrected from "Via Zoom"
);
class MeetingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(  // Add scrollable functionality
        child: Padding(
          padding: const EdgeInsets.all(0.0), // Adjusted padding for better look
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// First Card with Gradient Background
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.skyBlue, AppColors.mintGreen], // Customize gradient colors
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SessionsCard(
                    imagePath: 'assets/images/Sessionimg.png',
                    topic: 'Topic',
                    subtitle: 'Anger management & benefits.',
                    speaker: 'Dr. Dinesh Acharjya',
                    message: 'Physical medicine & Rehabilitation',
                    duration: '30-45 min',
                    time: '12:45 min',
                    joinedCount: 50,
                    buttonText: 'Join now',
                    joinedAvatars: [
                      "assets/images/avatar1.png",
                      "assets/images/avatar2.png",
                      "assets/images/avatar3.png",
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20), // Space between the cards

              /// Second Card (same as the first one)
              MeetingCard(
              topicTextStyle: const TextStyle(color: AppColors.grey),
              titleText: 'Stress management tips!'
              ,
              titleTextStyle: const TextStyle(
                color: AppColors.royalBlue,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
              headingText: 'Upcoming Meetings',
              rescheduleText: 'Re-schedule',
              meeting: meeting,
              onCancel: () => print("Meeting cancelled"),
              onReschedule: () => print("Meeting rescheduled"),
            ),

              const SizedBox(height: 20), // Add more cards if needed

              /// Third Card (add as needed)
              SessionsCard(
                imagePath: 'assets/images/Sessionimg.png',
                topic: 'Topic',
                subtitle: 'Self-care and mindfulness.',
                speaker: 'Dr. Jane Smith',
                message: 'Mental Health & Wellness',
                duration: '20-30 min',
                time: '10:30 am',
                joinedCount: 20,
                buttonText: 'Join now',
                joinedAvatars: [
                  "assets/images/avatar1.png",
                  "assets/images/avatar2.png",
                  "assets/images/avatar3.png",
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
