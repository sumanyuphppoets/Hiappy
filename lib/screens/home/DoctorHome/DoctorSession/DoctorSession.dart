import 'package:flutter/material.dart';
import 'package:hiappy/screens/home/DoctorHome/DoctorSession/DoctorTabMetting.dart';
import 'package:hiappy/screens/home/DoctorHome/DoctorSession/DoctorTabSession.dart';
import 'package:hiappy/widgets/TopTabs/DynamicTopTabs.dart';

class DoctorSessionScreen extends StatelessWidget {
  const DoctorSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DynamicTopTabs(
        title: "",
        tabTitles: ["Session","Metting" ],
        tabViews: [DoctorTabSession(),DoctorTabMetting(), ],
      ),
    );
  }
}
