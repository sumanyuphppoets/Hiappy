import 'package:flutter/material.dart';
import 'package:hiappy/core/constants/colors.dart';
import 'package:hiappy/screens/home/PatientHome/SessionHistory/SessionHistory.dart';
import 'package:hiappy/widgets/Invitations/Invitations.dart';
import 'package:hiappy/widgets/Searchcard/Searchcard.dart';
import 'package:hiappy/widgets/SessionRequests/SessionRequests.dart';
import 'package:hiappy/widgets/Sessionscard/SessionsCard.dart';
import 'package:hiappy/widgets/UpcomingMeetings/UpcomingMeetings.dart';

// Placeholder for meeting data
final Meeting meeting = Meeting(
  topic: "Topic",
  mentor: "Speaker: Dr. Dinesh Acharjya ",
  imagePath: "assets/images/Sessionimg.png",
  dateTime: DateTime(2024, 7, 20, 12, 45),
  duration: "30-45 min",
  platform: "Via Zoom", // ✅ Corrected from "Via Zoom"
);
final List<Map<String, String>> sessionData = [
  {
    'imageUrl': 'assets/images/History_img.png',
    'title': 'Stress management tips!',
    'subtitle': 'Lorem ipsum dolor sit amet...',
    'duration': '45:12',
  },
  {
    'imageUrl': 'assets/images/History_img.png',
    'title': 'Stress management tips!',
    'subtitle': 'Lorem ipsum dolor sit amet...',
    'duration': '45:12',
  },
  {
    'imageUrl': 'assets/images/History_img.png',
    'title': 'Stress management tips!',
    'subtitle': 'Lorem ipsum dolor sit amet...',
    'duration': '45:12',
  },
  {
    'imageUrl': 'assets/images/History_img.png',
    'title': 'Stress management tips!',
    'subtitle': 'Lorem ipsum dolor sit amet...',
    'duration': '45:12',
  },
];

List<SessionData> sessions = [
  SessionData(
    topic: "Stress management tips!",
    createdBy: "Abhijeet Patel",
    date: "July 20, 2024",
    time: "12:45 pm",
    duration: "30-45 min via Zoom",
    mode: "Via Zoom",
  ),
  SessionData(
    topic: "Boosting productivity",
    createdBy: "Neha Sharma",
    date: "July 21, 2024",
    time: "10:30 am",
    duration: "40 min via Zoom",
    mode: "Via Zoom",
  ),
  SessionData(
    topic: "Healthy Mindset",
    createdBy: "Ravi Kumar",
    date: "July 22, 2024",
    time: "2:00 pm",
    duration: "30 min via Zoom",
    mode: "Via Zoom",
  ),
  SessionData(
    topic: "Time management",
    createdBy: "Simran Kaur",
    date: "July 23, 2024",
    time: "1:00 pm",
    duration: "45 min via Zoom",
    mode: "Via Zoom",
  ),
  SessionData(
    topic: "Work-Life Balance",
    createdBy: "Mohit Verma",
    date: "July 24, 2024",
    time: "3:30 pm",
    duration: "30-45 min via Zoom",
    mode: "Via Zoom",
  ),
];

final List<SessionHistoryItem> items =
    sessionData.map((data) {
      return SessionHistoryItem(
        imageUrl: data['imageUrl'] ?? '',
        title: data['title'] ?? '',
        subtitle: data['subtitle'] ?? '',
        duration: data['duration'] ?? '',
      );
    }).toList();

class MeetingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Add scrollable functionality
        child: Padding(
          padding: const EdgeInsets.all(
            0.0,
          ), // Adjusted padding for better look
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// First Card with Gradient Background
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.skyBlue,
                      AppColors.mintGreen,
                    ], // Customize gradient colors
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
                titleText: 'Stress management tips!',
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
              const SizedBox(height: 20),
              InvitationsList(
                invitations: [
                  Invitation(
                    title: 'Stress management tips!',
                    speaker: 'Dr. Dinesh Acharjya',
                    dateTime: DateTime.now(),
                    duration: '30 mins',
                    imagePath: 'assets/images/Invitations.png',
                    onAccept: () => print('Accepted!'),
                    onDecline: () => print('Declined!'),
                    acceptLabel: 'Accept',
                    declineLabel: 'Decline',
                    titleStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ), // Add more invitations here
                ],
              ),
              const SizedBox(height: 20),
              SearchCardList(
                seeMoreText: 'See more',
                titleText: 'Session History',
                onSeeMore: () {
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(builder: (context) => SessionHistory()),
                  );
                },
                items: items,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: SessionRequests(
                  headerText: 'Session Requests',
                  actionText: 'See more',
                  onActionClick: () {},
                  onAccept: (session) => {},
                  onReject: (session) => {},
                  sessions: sessions,
                  acceptButtonText: 'I’m Interested',
                  rejectButtonText: 'Decline',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
