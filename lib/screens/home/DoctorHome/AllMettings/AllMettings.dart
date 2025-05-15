import 'package:flutter/material.dart';
import 'package:hiappy/screens/home/PatientHome/AllMettings/TabScreens/Intrested.dart';
import 'package:hiappy/screens/home/PatientHome/AllMettings/TabScreens/Meetings.dart';
import 'package:hiappy/widgets/TopTabs/DynamicTopTabs.dart';

class AllMeetings extends StatelessWidget {
  const AllMeetings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DynamicTopTabs(
        title: "",
        tabTitles: ["All Meetings","I’m Interested" ],
        tabViews: [MeetingsScreen(),InterestedScreen(), ],
      ),
    );
  }
}