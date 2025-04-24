import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hiappy/core/constants/colors.dart';
import 'package:hiappy/screens/home/PatientHome/AllMettings/AllMettings.dart';
import 'package:hiappy/screens/home/PatientHome/AllSession/AllSession.dart';
import 'package:hiappy/screens/home/PatientHome/SessionHistory/SessionHistory.dart';
import 'package:hiappy/widgets/CustomInput.dart';
import 'package:hiappy/widgets/Searchcard/Searchcard.dart';
import 'package:hiappy/widgets/SessionRequests/SessionRequests.dart';
import 'package:hiappy/widgets/UpcomingMeetings/UpcomingMeetings.dart';
import 'package:hiappy/widgets/custom_dropdown.dart';
import 'package:hiappy/widgets/gradient_button.dart';

// Placeholder for meeting data
final Meeting meeting = Meeting(
  topic: "Topic",
  mentor: "Abhijeet Patel",
  dateTime: DateTime(2024, 7, 20, 12, 45),
  duration: "30-45 min",
  platform: "Via Zoom", // ✅ Corrected from "Via Zoom"
);

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

final List<SessionHistoryItem> items =
    sessionData.map((data) {
      return SessionHistoryItem(
        imageUrl: data['imageUrl'] ?? '',
        title: data['title'] ?? '',
        subtitle: data['subtitle'] ?? '',
        duration: data['duration'] ?? '',
      );
    }).toList();

class TabSessionScreen extends StatelessWidget {
  const TabSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: SvgPicture.asset(
                      'assets/icons/SessionVideo.svg',
                      width: 100,
                      height: 80,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Need to discuss anything?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Lorem ipsum dolor sit amet consectetur. Dignissim non magna et.",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  GradientButton(
                    title: 'Create a Session',
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
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return DraggableScrollableSheet(
                            initialChildSize: 0.85,
                            maxChildSize: 0.95,
                            minChildSize: 0.5,
                            expand: false,
                            builder:
                                (_, controller) => Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  child: SingleChildScrollView(
                                    controller: controller,
                                    child: const ScheduleSessionForm(),
                                  ),
                                ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // 🗓️ Upcoming Meeting Card
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
            const SizedBox(height: 30),
            SessionRequests(
              headerText: 'Session Requests',
              actionText: 'See more',
              onActionClick: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AllMeetings(),
                    ),
                  );},
              onAccept: (session) => {},
              onReject: (session) => {},
              sessions: sessions,
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: SearchCardList(
                seeMoreText: 'See more',
                titleText: 'Session History',
                items: items,
                onSeeMore: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SessionHistory(),
                    ),
                  );
                },
              ),
            ),  
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: MeetingCard(
              topicTextStyle: const TextStyle(color: AppColors.grey),
              titleText: 'Stress management tips!',
              titleTextStyle: const TextStyle(
                color: AppColors.royalBlue,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
              headingText: 'All Session',
              rescheduleText: 'Re-schedule',
              seeMoreText: 'See more',
              onSeeMore: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AllSession(),
                  ),
                );
              },
              meeting: meeting,
              onCancel: () => print("Meeting cancelled"),
              onReschedule: () => print("Meeting rescheduled"),
            ),
            ),            // 🗓️ Upcoming Meeting Card
            
          ],
        ),
      ),
    );
  }
}

// 📋 Modal Form
class ScheduleSessionForm extends StatefulWidget {
  const ScheduleSessionForm({super.key});

  @override
  _ScheduleSessionFormState createState() => _ScheduleSessionFormState();
}

class _ScheduleSessionFormState extends State<ScheduleSessionForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController topicController = TextEditingController();
  final TextEditingController mentorController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  String selectedAmPm = "AM";
  String? selectedDuration;
  final List<String> durations = [
    '5 - 10 mins',
    '10 - 15 mins',
    '15 - 30 mins',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Create a session schedule",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 20),

              // 📝 Topic
              CustomInput(
                hint: 'Topics of meeting',
                iconAsset: 'assets/icons/MettingTopic.svg',
                controller: topicController,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Please enter a topic'
                            : null,
              ),

              // 👨 Mentor
              CustomInput(
                hint: 'Doctor/Mentor name',
                iconAsset: 'assets/icons/Doctoricon.svg',
                controller: mentorController,
                iconSize: 25,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Please enter a name'
                            : null,
              ),

              // 📅 Date Picker
              GestureDetector(
                onTap: _pickDate,
                child: AbsorbPointer(
                  child: CustomInput(
                    hint: 'Select Date',
                    iconAsset: 'assets/icons/DateSelect.svg',
                    controller: dateController,
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'Please select a date'
                                : null,
                  ),
                ),
              ),

              // 🕒 Time Picker + AM/PM
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: _pickTime,
                      child: AbsorbPointer(
                        child: CustomInput(
                          hint: 'Select Time',
                          iconAsset: 'assets/icons/Time.svg',
                          controller: timeController,
                          validator:
                              (value) =>
                                  value == null || value.isEmpty
                                      ? 'Please select time'
                                      : null,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: DropdownButton<String>(
                      value: selectedAmPm,
                      underline: SizedBox(),
                      onChanged: (val) {
                        setState(() => selectedAmPm = val!);
                      },
                      items:
                          ["AM", "PM"]
                              .map(
                                (e) =>
                                    DropdownMenuItem(child: Text(e), value: e),
                              )
                              .toList(),
                    ),
                  ),
                ],
              ),

              // ⏱️ Duration Dropdown
              CustomDropdown(
                hint: 'Select Duration',
                prefixIconAsset: 'assets/icons/video_icon.svg',
                prefixIconHeight: 15,
                prefixIconWidth: 15,
                arrowColor: AppColors.royalBlue,
                items: durations,
                initialValue: selectedDuration,
                onChanged: (value) {
                  setState(() {
                    selectedDuration = value;
                  });
                },
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Please select a duration'
                            : null,
              ),

              const SizedBox(height: 20),

              GradientButton(
                title: 'Create a schedule session',
                borderRadius: 30,
                height: 50,
                width: double.infinity,
                textSize: 16,
                gradient: LinearGradient(
                  colors: [AppColors.darkeBlue, AppColors.lightBlue],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (_) => CongratulationCard(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      dateController.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  Future<void> _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      timeController.text = picked.format(context);
    }
  }
}

// 🎉 Congratulations Card
class CongratulationCard extends StatelessWidget {
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
          Text(
            "Congratulations!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text("Your session has been scheduled successfully."),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Optional: Add navigation to home if needed
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            ),
            child: Text("Back to Home"),
          ),
        ],
      ),
    );
  }
}
