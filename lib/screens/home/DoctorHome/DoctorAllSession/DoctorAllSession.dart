import 'package:flutter/material.dart';
import 'package:hiappy/core/constants/colors.dart';
import 'package:hiappy/widgets/UpcomingMeetings/UpcomingMeetings.dart';

class DoctorAllSession extends StatelessWidget {
  final List<Meeting> meetings = [
    Meeting(
      topic: "Stress management tips!",
      mentor: "Abhijeet Patel",
      dateTime: DateTime(2024, 7, 20, 12, 45),
      duration: "30-45 min",
      platform: "Via Zoom",
    ),
    Meeting(
      topic: "Time Management",
      mentor: "Neha Sharma",
      dateTime: DateTime(2024, 8, 10, 14, 30),
      duration: "60 min",
      platform: "Google Meet",
    ),
    Meeting(
      topic: "Dealing with anxiety",
      mentor: "Rahul Verma",
      dateTime: DateTime(2024, 9, 5, 11, 0),
      duration: "45 min",
      platform: "Via Zoom",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        itemCount: meetings.length,
        itemBuilder: (context, index) {
          final meeting = meetings[index];

          // Add extra bottom padding for last card
          final isLast = index == meetings.length - 1;
          final padding = EdgeInsets.only(
            bottom: isLast ? 24.0 : 12.0,
          );

          return Padding(
            padding: padding,
            child: MeetingCard(
              topicTextStyle: const TextStyle(color: AppColors.grey),
              
              titleText: meeting.topic,
              titleTextStyle: const TextStyle(
                color: AppColors.royalBlue,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
              headingText: index == 0 ? 'All Sessions' : null,
              rescheduleText: 'Re-schedule',
              cancelText: 'Cancel',
              cancelGradientColors: [AppColors.darkeBlue, AppColors.lightBlue],
              meeting: meeting,
              onCancel: () => print("Meeting cancelled: ${meeting.topic}"),
              onReschedule: () =>
                  print("Meeting rescheduled: ${meeting.topic}"),
            ),
          );
        },
      ),
    );
  }
}
