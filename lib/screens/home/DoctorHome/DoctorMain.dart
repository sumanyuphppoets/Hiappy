import 'package:flutter/material.dart';
import 'package:hiappy/core/constants/colors.dart';
import 'package:hiappy/screens/home/DoctorHome/PatientDetails/PatientDetails.dart';
import 'package:hiappy/screens/home/PatientHome/AllSession/AllSession.dart';
import 'package:hiappy/screens/home/PatientHome/MettingRequest/MettingRequest.dart';
import 'package:hiappy/widgets/PatientCard/PatientCard.dart';
import 'package:hiappy/widgets/UpCommingMeeting/UpComming.dart';
import 'package:hiappy/widgets/UpcomingMeetings/UpcomingMeetings.dart';

final Meeting meeting = Meeting(
  topic: "Topic",
  mentor: "Abhijeet Patel",
  dateTime: DateTime(2024, 7, 20, 12, 45),
  duration: "30-45 min",
  platform: "Via Zoom",
);

class DoctorMain extends StatelessWidget {
  const DoctorMain({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Removed invalid entry
            PatientCard(
              name: "New Patients",
              user: true,
              onCardTap: (Patient patient) {
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(
                    builder: (context) => PatientDetails(patient: patient),
                  ),
                );
              },

              patients: [
                Patient(
                  name: "Nitin Kumar",
                  age: 28,
                  gender: "Male",
                  center: "New Life Rehabilitation Center",
                  imageUrl: "assets/images/Patientsimg.png",
                  backgroundColor: Colors.blue[50],
                ),
                Patient(
                  name: "Obhiro Kundu",
                  age: 26,
                  gender: "Male",
                  center: "New Life Rehabilitation Center",
                  imageUrl: "assets/images/Patientsimg.png",
                ),
                Patient(
                  name: "Obhiro Kundu",
                  age: 26,
                  gender: "Male",
                  center: "New Life Rehabilitation Center",
                  imageUrl: "assets/images/Patientsimg.png",
                ),
                Patient(
                  name: "Obhiro Kundu",
                  age: 26,
                  gender: "Male",
                  center: "New Life Rehabilitation Center",
                  imageUrl: "assets/images/Patientsimg.png",
                ),
                Patient(
                  name: "Obhiro Kundu",
                  age: 26,
                  gender: "Male",
                  center: "New Life Rehabilitation Center",
                  imageUrl: "assets/images/Patientsimg.png",
                ),
                Patient(
                  name: "Obhiro Kundu",
                  age: 26,
                  gender: "Male",
                  center: "New Life Rehabilitation Center",
                  imageUrl: "assets/images/Patientsimg.png",
                ),
                Patient(
                  name: "Anjali Verma",
                  age: 30,
                  gender: "Female",
                  center: "Healing Hands Wellness Center",
                  imageUrl: "assets/images/Patientsimg.png",
                ),
              ],
            ),
            SizedBox(height: 20), // Spacing between cards
            PatientCard(
              name: "Assigned Patients ",
              user: false,
              onSeeMore: () {
                // Handle see more action
              },
              onCardTap: (Patient patient) {
                // Handle card tap
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PatientDetails(patient: patient),
                  ),
                );
              },

              patients: [
                Patient(
                  name: "Rahul Sharma",
                  age: 35,
                  gender: "Male",
                  center: "Hope Recovery Center",
                  imageUrl: "assets/images/Patientsimg.png",
                ),
                Patient(
                  name: "Sneha Mehta",
                  age: 32,
                  gender: "Female",
                  center: "Wellbeing Care Center",
                  imageUrl: "assets/images/Patientsimg.png",
                ),
              ],
            ),
            const SizedBox(height: 20),
            MeetingCard(
              topicTextStyle: TextStyle(color: AppColors.grey),
              titleText: 'Stress management tips!',
              titleTextStyle: TextStyle(
                color: AppColors.royalBlue,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
              headingText: 'Upcoming Meetings',
              seeMoreText: 'See more',
              rescheduleText: 'Re-schedule',
              cancelText: 'Cancel',
              cancelGradientColors: [AppColors.darkeBlue, AppColors.lightBlue],
              meeting: meeting,
              onSeeMore: () {
                Navigator.of(
                  context,
                  rootNavigator: false,
                ).push(MaterialPageRoute(builder: (context) => AllSession()));
              },
              onCancel: () {
                print("Meeting cancelled");
              },
              onReschedule: () {
                print("Meeting rescheduled");
              },
            ),
            const SizedBox(height: 40),
            UpComming(
              headingText: 'Running Meetings',
              seeMoreText: 'See more',
              onSeeMore: () {
                Navigator.of(context, rootNavigator: false).push(
                  MaterialPageRoute(builder: (context) => MeetingRequest()),
                );
              },
              imagePath: 'assets/images/Sessionimg.png',
              topic: 'Topic',
              subtitle: 'Anger management & benefits.',
              speaker: 'Dr. Dinesh Acharjya ',
              message: 'Physical medicine & Rehabilitation',
              duration: '30-45 min',
              buttonText: 'Invite to join',
              platform: 'Via Zoom',
              Join: 'Start the meeting',
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
