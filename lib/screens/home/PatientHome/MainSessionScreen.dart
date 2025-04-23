import 'package:flutter/material.dart';
import 'package:hiappy/screens/home/PatientHome/MeetingScreen/MeetingScreen.dart';
import 'package:hiappy/screens/home/PatientHome/Sessionscreen/Session.dart';
import 'package:hiappy/widgets/CustomAppbar/PatientCustomAppbar.dart';
import 'package:hiappy/widgets/TopTabs/DynamicTopTabs.dart';

class MainSessionScreen extends StatefulWidget {
  @override
  _MainSessionScreenState createState() => _MainSessionScreenState();
}

class _MainSessionScreenState extends State<MainSessionScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DynamicTopTabs(
        title: "Sessions",
        tabTitles: ["Session", "Metting"],
        tabViews: [SessionScreen(), MeetingScreen()],
      ),
    );
  }
}
