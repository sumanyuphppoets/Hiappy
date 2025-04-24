import 'package:flutter/material.dart';
import 'package:hiappy/screens/home/PatientHome/TabMettingScreen/TabMettingScreen.dart';
import 'package:hiappy/screens/home/PatientHome/TabSessionScreen/TabSessionScreen.dart';
import 'package:hiappy/widgets/TopTabs/DynamicTopTabs.dart';

class MainSessionScreen extends StatelessWidget {
  const MainSessionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DynamicTopTabs(
        title: "",
        tabTitles: ["Session","Metting" ],
        tabViews: [TabSessionScreen(),TabMeetingScreen(), ],
      ),
    );
  }
}
