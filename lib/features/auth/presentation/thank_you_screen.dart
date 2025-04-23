import 'package:flutter/material.dart';
import 'package:hiappy/features/auth/presentation/login.dart';
import 'package:hiappy/widgets/gradient_button.dart'; // Ensure this is your custom GradientButton widget

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAFF),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/splash_screen_logo.png', // Update with your actual path
                  height: 80,
                ),
                const SizedBox(height: 30),
                const Text(
                  'Thank You!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2563EB), // Blue shade
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Your request is under review,\nwe will notify once it is verified.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 60),
                GradientButton(
                  title: 'Back to Login',
                  textSize: 16,
                  borderRadius: 30,
                  height: 60,
                  width: 300,
                  svgIconPath:
                      'assets/icons/arrow_right.svg', // Add this SVG icon to assets
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF06B6D4)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => LoginPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
