import 'package:flutter/material.dart';
import 'package:hiappy/features/auth/presentation/role_selection_screen.dart';
import 'package:hiappy/screens/home/DoctorHome/DoctorHome.dart';
import 'package:hiappy/screens/home/FamilyHome/FamilyHome.dart';
import 'package:hiappy/screens/home/MentorHome/MentorHome.dart';
import 'package:hiappy/screens/home/PatientHome/PatientHome.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DecideHomeByRole extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _getHomeWidget(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text('Error loading home')));
        } else if (snapshot.hasData) {
          return snapshot.data!;
        } else {
          // Fallback to a default screen if no data found
          return Scaffold(body: Center(child: Text('No role found')));
        }
      },
    );
  }

  Future<Widget> _getHomeWidget() async {
    final prefs = await SharedPreferences.getInstance();
    final role = prefs.getString('user_role') ?? '';

    switch (role) {
      case 'Patient':
        return PatientHome();
      case 'Doctor':
        return DoctorHome();
      case 'Mentor':
        return MentorHome();
      case 'Family Member':
        return FamilyHome();
      default:
        // Fallback to role selection screen if no valid role found
        return RoleSelectionScreen();
    }
  }
}