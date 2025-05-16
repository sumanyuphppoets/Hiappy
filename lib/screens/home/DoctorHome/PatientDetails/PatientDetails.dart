import 'package:flutter/material.dart';
import 'package:hiappy/core/constants/colors.dart';
import 'package:hiappy/screens/home/DoctorHome/MettingRequest/MettingRequest.dart';
import 'package:hiappy/screens/home/PatientHome/AllSession/AllSession.dart';
import 'package:hiappy/widgets/CustomInput.dart';
import 'package:hiappy/widgets/DoctorNotificationCard/NotificationCard.dart';
import 'package:hiappy/widgets/PatientCard/PatientCard.dart';
import 'package:hiappy/widgets/UpCommingMeeting/UpComming.dart';
import 'package:hiappy/widgets/UpcomingMeetings/UpcomingMeetings.dart';
import 'package:hiappy/widgets/gradient_button.dart';
import 'package:hiappy/widgets/gradient_outline_button.dart';
import 'package:hiappy/widgets/title_text.dart';
import 'package:url_launcher/url_launcher.dart';

class PatientDetails extends StatelessWidget {
  final Patient patient;
  final TextEditingController fullNameController = TextEditingController();

  PatientDetails({super.key, required this.patient});

  void callNow(BuildContext context, String phoneNumber) async {
    final Uri uri = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(uri)) {
      try {
        final bool launched = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
        if (!launched) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not launch the dialer app.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error launching dialer: $e')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No dialer found on this device.')),
      );
    }
  }

  List<Map<String, String>> notifications = [
    {
      "day": "Today",
      "message": "You have a new message",
      "reply": "Okay",
      "time": "10:00 AM",
    },
    {
      "day": "Today",
      "message": "Order confirmed",
      "reply": "Thanks",
      "time": "9:00 AM",
    },
    {
      "day": "Yesterday",
      "message": "Package shipped",
      "reply": "Got it",
      "time": "8:00 PM",
    },
    {
      "day": "Yesterday",
      "message": "Appointment rescheduled",
      "reply": "Noted",
      "time": "4:30 PM",
    },
    {
      "day": "2 days ago",
      "message": "New lab results available",
      "reply": "Reviewing",
      "time": "11:15 AM",
    },
  ];

  final Meeting meeting = Meeting(
  topic: "Topic",
  mentor: "Abhijeet Patel",
  dateTime: DateTime(2024, 7, 20, 12, 45),
  duration: "30-45 min",
  platform: "Via Zoom",
);


  String lastDay = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlueTransparent,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Image with Back Button overlay
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    patient.imageUrl,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top + 8,
                  left: 12,
                  child: CircleAvatar(
                    backgroundColor: Colors.white70,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                transform: Matrix4.translationValues(0.0, -100, 0.0),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 25,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F8F9),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TitleText(
                      text: patient.name,
                      color: AppColors.royalBlue,
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    TitleText(
                      text: 'Age: ${patient.age}, ${patient.gender}',
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    TitleText(
                      text: patient.center,
                      color: AppColors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: GradientOutlineButton(
                            title: 'Create a meeting',
                            gradientColors: const [
                              Color(0xFFB575EA),
                              Color(0xFFEC758F),
                            ],
                            borderRadius: 30,
                            width: double.infinity,
                            fontSize: 12,
                            onTap: () {
                              print("Create meeting tapped!");
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GradientButton(
                            title: "Call now",
                            gradient: const LinearGradient(
                              colors: [Color(0xFF4D66E2), Color(0xFF3ABAEB)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: 30,
                            onPressed: () => callNow(context, '7014132321'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Patient Status Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                transform: Matrix4.translationValues(0.0, -70, 0.0),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF75B5EB), Color(0xFF75EC99)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TitleText(
                      text: "Patient’s Current Status",
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    TitleText(
                      text: "GOOD",
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            // Medical History Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TitleText(
                text: "Medical History",
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.left,
              ),
            ),

            const SizedBox(height: 20),

            // Uploaded Documents Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F8F9),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleText(
                      text: "Uploaded documents",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(3, (index) {
                        return Column(
                          children: [
                            Image.asset(
                              'assets/images/pdf_icon.png',
                              height: 50,
                              width: 50,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Prescriptions",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "20.01 KB",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: GradientOutlineButton(
                        title: 'Upload documents',
                        gradientColors: const [
                          Color(0xFF3ABAEB),
                          Color(0xFF4D66E2),
                        ],
                        borderRadius: 30,
                        width: double.infinity,
                        fontSize: 16,
                        textColor: AppColors.royalBlue,
                        onTap: () {
                          print("Upload documents tapped!");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TitleText(
                        text: "Notifications",
                        color: AppColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        textAlign: TextAlign.left,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Add your navigation or action here
                          print("Notification clicked!");
                        },
                        child: TitleText(
                          text: "1 new notification",
                          color: AppColors.royalBlue,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10), // optional spacing below
                ],
              ),
            ),

            const SizedBox(height: 20),
            // Notification Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFB24010),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: const Icon(
                            Icons.local_bar,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Mitra is near to an alcohol serving zone!",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 6),
                              TextButton(
                                onPressed: () {
                                  // Reply button logic
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.royalBlue,
                                  side: BorderSide(color: AppColors.royalBlue),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text("Send a reply"),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "5 min ago",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: EdgeInsetsGeometry.fromLTRB(70, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Reply:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          CustomInput(
                            controller: fullNameController,
                            maxLines: 3,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return '';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: GradientOutlineButton(
                        title: 'Send',
                        gradientColors: const [
                          AppColors.royalBlue,
                          AppColors.lightBlue,
                        ],
                        borderRadius: 30,
                        width: 150,
                        fontSize: 12,
                        onTap: () {
                          print("Create meeting tapped!");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TitleText(
                        text: "Notifications History",
                        color: AppColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        textAlign: TextAlign.left,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Add your navigation or action here
                          print("Notification See more clicked!");
                        },
                        child: TitleText(
                          text: "See more",
                          color: AppColors.royalBlue,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              notifications.map((item) {
                                bool showDay = item["day"] != lastDay;
                                lastDay = item["day"]!;
                                return NotificationCard(
                                  message: item["message"]!,
                                  reply: item["reply"]!,
                                  time: item["time"]!,
                                  day: item["day"]!,
                                  showDay: showDay,
                                );
                              }).toList(),
                        ),
                      ],
                    ),
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
                    headingText: 'Scheduled Meetings',
                    rescheduleText: 'Re-schedule',
                    cancelText: 'Cancel',
                    cancelGradientColors: [
                      AppColors.darkeBlue,
                      AppColors.lightBlue,
                    ],
                    meeting: meeting,
                    onCancel: () {
                      print("Meeting cancelled");
                    },
                    onReschedule: () {
                      print("Meeting rescheduled");
                    },
                  ),
                  const SizedBox(height: 40),
                  UpComming(
                    headingText: 'Upcoming Session',
                    imagePath: 'assets/images/Sessionimg.png',
                    topic: 'Topic',
                    subtitle: 'Anger management & benefits.',
                    speaker: 'Dr. Dinesh Acharjya ',
                    message: 'Physical medicine & Rehabilitation',
                    duration: '30-45 min',
                    platform: 'Via Zoom',
                    Join: 'Invite now',
                    
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
