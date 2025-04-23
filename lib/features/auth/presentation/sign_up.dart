import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hiappy/core/constants/colors.dart';
import 'package:hiappy/features/auth/presentation/Doctor/doctor_email_signup.dart';
import 'package:hiappy/features/auth/presentation/Family_member/family_email_signup.dart';
import 'package:hiappy/features/auth/presentation/Mentor/email_signup_screen.dart';
import 'package:hiappy/features/auth/presentation/Patient/email_signup_screen.dart';
import 'package:hiappy/features/auth/presentation/login.dart';
import 'package:hiappy/widgets/gradient_outline_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class SignUpPage extends StatelessWidget {
  final String selectedRole;
  SignUpPage({super.key, required this.selectedRole});

  final List<Map<String, dynamic>> roles = [
    {
      'title': 'Continue with Email',
      'colors': [Color(0xFF75B5EB), Color(0xFF75EC99)],
      'svgAssets': 'assets/icons/Email.svg',
      'method': 'email',
    },
    {
      'title': 'Continue with Google',
      'colors': [Color(0xFFEB77CA), Color(0xFF968FFB)],
      'svgAssets': 'assets/icons/Google.svg',
      'method': 'google',
    },
    {
      'title': 'Continue with Facebook',
      'colors': [Color(0xFF75E9F0), Color(0xFF757CF0)],
      'svgAssets': 'assets/icons/Facebook.svg',
      'method': 'facebook',
    },
    if (Platform.isIOS)
      {
        'title': 'Continue with Apple',
        'colors': [Color(0xFF000000), Color(0xFF666666)],
        'svgAssets': 'assets/icons/Apple.svg',
        'method': 'apple',
      },
  ];

  void _handleSignUp(BuildContext context, String method) async {
    Future<UserCredential?>? signInFuture;

    if (method == 'google') {
      signInFuture = AuthService.signInWithGoogle();
    } else if (method == 'facebook') {
      signInFuture = AuthService.signInWithFacebook();
    } else if (method == 'apple') {
      if (Platform.isIOS) {
        signInFuture = AuthService.signInWithApple();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Apple sign-in is only available on iOS devices'),
          ),
        );
        return;
      }
    } else if (method == 'email') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmailSignupScreen(selectedRole: selectedRole),
        ),
      );
      return;
    }

    if (signInFuture != null) {
      final userCredential = await signInFuture;
      if (userCredential != null) {
        final isNew = userCredential.additionalUserInfo?.isNewUser == true;
        final user = userCredential.user;
        final name = user?.displayName ?? "";
        final email = user?.email ?? "";
        final phone = user?.phoneNumber ?? "";

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isNew
                  ? 'Welcome! Signed up as $name'
                  : 'Welcome back! Signed in as $name',
            ),
          ),
        );

        // Navigate based on selectedRole
        switch (selectedRole) {
          case 'Patient':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder:
                    (context) => EmailSignupScreen(
                      selectedRole: selectedRole,
                      name: name,
                      email: email,
                      phone: phone,
                      method: method,
                    ),
              ),
            );
            break;
          case 'Doctor':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder:
                    (context) => DoctorSignupScreen(
                      selectedRole: selectedRole,
                      name: name,
                      email: email,
                      phone: phone,
                      method: method,
                    ),
              ),
            );
            break;
          case 'Mentor':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder:
                    (context) => MentorSignupScreen(
                      selectedRole: selectedRole,
                      name: name,
                      email: email,
                      phone: phone,
                      method: method,
                    ),
              ),
            );
            break;
          case 'Family Member':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder:
                    (context) => FamilyEmailSignup(
                      selectedRole: selectedRole,
                      name: name,
                      email: email,
                      phone: phone,
                      method: method,
                    ),
              ),
            );
            break;
          default:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder:
                    (context) => EmailSignupScreen(selectedRole: selectedRole),
              ),
            );
        }
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Sign in failed')));
      }
    }
  }

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
                Text(
                  'Sign up as $selectedRole',
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 100),
                ...roles.map(
                  (role) => GradientOutlineButton(
                    title: role['title'],
                    gradientColors: role['colors'],
                    width: 320,
                    svgAssetPath: role['svgAssets'],
                    iconSize: 25,
                    onTap: () => _handleSignUp(context, role['method']),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                      children: [
                        const TextSpan(
                          text: 'By clicking continue, you agree to our ',
                        ),
                        TextSpan(
                          text: 'Terms & Conditions',
                          style: const TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  print('Terms & Conditions tapped');
                                },
                        ),
                        const TextSpan(
                          text: ' and acknowledge that you have read our ',
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: const TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  print('Privacy Policy tapped');
                                },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                      children: [
                        const TextSpan(text: 'Have an account? '),
                        TextSpan(
                          text: 'Log in',
                          style: const TextStyle(
                            color: AppColors.royalBlue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => LoginPage(selectedRole: selectedRole),
                                    ),
                                  );
                                },
                        ),
                      ],
                    ),
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
