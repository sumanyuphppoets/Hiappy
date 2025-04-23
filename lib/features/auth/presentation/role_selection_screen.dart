import 'package:flutter/material.dart';
import 'package:hiappy/core/constants/colors.dart';
import 'package:hiappy/features/auth/presentation/sign_up.dart';
import 'package:hiappy/screens/home/GuestHome/GuestHome.dart';
import 'package:hiappy/widgets/gradient_outline_button.dart';
import 'package:hiappy/widgets/title_text.dart';

class RoleSelectionScreen extends StatelessWidget {
  RoleSelectionScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> roles = [
    {
      'title': 'Patient',
      'colors': [Color(0xFF3FE29D), Color(0xFF24C6DC)],
    },
    {
      'title': 'Doctor',
      'colors': [Color(0xFF24C6DC), Color(0xFF514A9D)],
    },
    {
      'title': 'Mentor',
      'colors': [Color(0xFFFF6A6A), Color(0xFFAA076B)],
    },
    {
      'title': 'Family Member',
      'colors': [Color(0xFFFF6A6A), Color(0xFFAA076B)],
    },
    {
      'title': 'Guest',
      'colors': [Color(0xFF24C6DC), Color(0xFF514A9D)],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAFF),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/splash_screen_logo.png', height: 80),
                const SizedBox(height: 20),
                const Text(
                  'Sign up to create an account',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 40),
                const TitleText(
                  text: 'I’m a',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.royalBlue,
                ),
                const SizedBox(height: 24),
                ...roles.map(
                  (role) => GradientOutlineButton(
                    title: role['title'],
                    gradientColors: role['colors'],
                    width: 300,
                    onTap: () {
                      final selectedRole = role['title'];

                      if (selectedRole == 'Guest') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => GuestHome()),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => SignUpPage(selectedRole: selectedRole),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
