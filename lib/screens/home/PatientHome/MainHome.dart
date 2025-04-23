import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hiappy/core/constants/colors.dart';
import 'package:hiappy/widgets/MentorCard/MentorCard.dart';
import 'package:hiappy/widgets/Sessionscard/SessionsCard.dart';
import 'package:hiappy/widgets/UpcomingMeetings/UpcomingMeetings.dart';
import 'package:hiappy/widgets/gradient_button.dart';
import 'package:hiappy/widgets/title_text.dart';

void main() {
  runApp(const MaterialApp(home: MainHome()));
}

final Meeting meeting = Meeting(
  topic: "Topic",
  mentor: "Abhijeet Patel",
  dateTime: DateTime(2024, 7, 20, 12, 45),
  duration: "30-45 min",
  platform: "Via Zoom", // ✅ Remove "Via" here
);

class MainHome extends StatelessWidget {
  const MainHome({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(38, 137, 208, 235),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: Row(
          children: [
          Expanded(
            child: SingleChildScrollView(
              // Make the Column scrollable
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const PerformanceCard(
                    userName: 'Sumanyu',
                    performanceLevel: 'Good',
                  ),
                  const SizedBox(height: 20),
                  GradientButton(
                    title: 'Have you taken a drink today?',
                    borderRadius: 30,
                    height: 60,
                    width: 350,
                    textSize: 16,
                    gradient: const LinearGradient(
                      colors: [AppColors.darkeBlue, AppColors.lightBlue],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          bool isChecked = true;

                          return StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                contentPadding: const EdgeInsets.all(20),
                                content: SizedBox(
                                  width: 300,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        'Have you taken a drink today?',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      CheckboxListTile(
                                        title: const Text(
                                          'Yes, I had a drink today',
                                        ),
                                        value: isChecked,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            isChecked = true;
                                          });
                                        },
                                      ),
                                      CheckboxListTile(
                                        title: const Text(
                                          "No, I hadn't drink today",
                                        ),
                                        value: !isChecked,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            isChecked = false;
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          print(
                                            "User response: ${isChecked ? 'Had a drink' : 'Hadn’t drink'}",
                                          );
                                        },
                                        child: Container(
                                          height: 50,
                                          width: double.infinity,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                AppColors.darkeBlue,
                                                AppColors.lightBlue,
                                              ],
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                          ),
                                          child: const Text(
                                            'Done',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TitleText(
                        text: 'Your Mentor',
                        textAlign: TextAlign.left,
                        paddingBottom: 10,
                      ),
                    ),
                  ),
                  // Add spacing between the cards
                  MentorCard(
                    name: 'Sumanyu Singh Rathore',
                    profession: 'Physical medicine & Rehabilitation',
                    image: 'assets/images/avatar3.png',
                    onCreateMeeting: () {},
                    onCallNow: () {},
                  ),
                  const SizedBox(height: 40),
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
                    meeting: meeting,
                    onSeeMore: () {
                      print("See more tapped");
                    },
                    onCancel: () {
                      print("Meeting cancelled");
                    },
                    onReschedule: () {
                      print("Meeting rescheduled");
                    },
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: SessionsCard(
                    headingText: 'Running Meetings',
                    seeMoreText: 'See more',
                    imagePath: 'assets/images/Sessionimg.png',
                    topic: 'Topic',
                    subtitle: 'Anger management & benefits.',
                    speaker: 'Dr. Dinesh Acharjya ',
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
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }
}

class PerformanceCard extends StatelessWidget {
  final String userName;
  final String performanceLevel;

  const PerformanceCard({
    super.key,
    required this.userName,
    required this.performanceLevel,
  });

  // Map levels to SVG filenames
  String getSvgPath(String level) {
    switch (level.toLowerCase()) {
      case 'very bad':
        return 'assets/images/VeryBad.svg';
      case 'bad':
        return 'assets/images/Bad.svg';
      case 'normal':
        return 'assets/images/Normal.svg';
      case 'good':
        return 'assets/images/Good.svg';
      case 'very good':
        return 'assets/images/VeryGood.svg';
      case 'excellent':
        return 'assets/images/Excellent.svg';
      default:
        return 'assets/images/Normal.svg';
    }
  }

  // Get color based on performance level
  Color getLevelColor(String level) {
    switch (level.toLowerCase()) {
      case 'excellent':
      case 'very good':
        return Colors.cyan;
      case 'good':
        return Colors.lightBlue;
      case 'normal':
        return Colors.orange;
      case 'bad':
      case 'very bad':
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final svgPath = getSvgPath(performanceLevel);

    return Container(
      width: 400,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 🔄 Show SVG based on performance level
          SvgPicture.asset(
            svgPath,
            width: 350,
            height: 200,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 16),
          ShaderMask(
            shaderCallback:
                (bounds) => const LinearGradient(
                  colors: [AppColors.softCyan, AppColors.slateBlue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                ),
            child: const Text(
              "Good Morning",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: Colors.white, // ✅ Required for gradient mask
              ),
            ),
          ),
          Text(
            "$userName!",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            "Your current performance status is:",
            style: TextStyle(fontSize: 14),
          ),
          Text(
            performanceLevel.toUpperCase() + "!",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: getLevelColor(performanceLevel),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "You’re doing great. Just need to\nkeep it up!",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
