import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hiappy/core/constants/colors.dart';
import 'package:hiappy/features/auth/presentation/login_otp.dart';
import 'package:hiappy/features/auth/presentation/otp_screen.dart';
import 'package:hiappy/features/auth/presentation/sign_up.dart';
import 'package:hiappy/screens/home/DoctorHome/DoctorHome.dart';
import 'package:hiappy/screens/home/FamilyHome/FamilyHome.dart';
import 'package:hiappy/screens/home/MentorHome/MentorHome.dart';
import 'package:hiappy/screens/home/PatientHome/PatientHome.dart';
import 'package:hiappy/widgets/CustomInput.dart';
import 'package:hiappy/widgets/gradient_button.dart';
import 'package:hiappy/widgets/gradient_outline_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hiappy/features/auth/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  final String selectedRole;
  const LoginPage({super.key,  this.selectedRole = 'null'});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;

  // Define loginMethods list
  final List<Map<String, dynamic>> loginMethods = [
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

void _handleLogin(BuildContext context) async {
  if (_formKey.currentState!.validate()) {
    final email = emailPhoneController.text.trim();
    final password = passwordController.text.trim();

    // Use the AuthService to attempt login
    final response = await AuthService.login(email, password);
    if (response['success']) {
      final data = response['data'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('firebase_token', data['token']);

      // ✅ Store role if available
      if (data.containsKey('role')) {
        await prefs.setString('user_role', data['role']);
      }

      // Navigate to the OTP page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => LoginOtpScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['error'])),
      );
    }
  }
}

void _handleSocialLogin(String method) async {
  UserCredential? userCredential;

  switch (method) {
    case 'google':
      userCredential = await AuthService.signInWithGoogle();
      break;
    case 'facebook':
      userCredential = await AuthService.signInWithFacebook();
      break;
    case 'apple':
      userCredential = await AuthService.signInWithApple();
      break;
    default:
      return;
  }

  final user = userCredential?.user;
  if (user != null && user.email != null) {
    final result = await AuthService.googlelogin(user.email!);
    if (!mounted) return;

    if (result['success'] == true) {
      final userData = result['data']['user'];
      final String role = userData['role'];

      // ✅ Save token and role
      final prefs = await SharedPreferences.getInstance();
      if (result['data']['token'] != null) {
        await prefs.setString('firebase_token', result['data']['token']);
      }
      await prefs.setString('user_role', role);

      // Navigate based on role
      Widget homePage;
      switch (role) {
        case 'Patient':
          homePage = PatientHome();
          break;
        case 'Doctor':
          homePage = DoctorHome();
          break;
        case 'Mentor':
          homePage = MentorHome();
          break;
        case 'Family Member':
          homePage = FamilyHome();
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unknown role: $role')),
          );
          return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User login successful')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => homePage),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed')),
      );
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
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset('assets/images/splash_screen_logo.png', height: 90),
                  const SizedBox(height: 24),
                  Text(
                    'Log in to enter',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Email or Phone Input
                  CustomInput(
                    hint: 'Email/Phone number',
                    iconAsset: 'assets/icons/Email.svg',
                    controller: emailPhoneController,
                    iconSize: 18,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email/phone number';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Password Input
                  CustomInput(
                    hint: 'Password',
                    iconAsset: 'assets/icons/Password.svg',
                    controller: passwordController,
                    iconSize: 18,
                    obscureText: obscurePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/forgot-password');
                      },
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(color: AppColors.royalBlue, fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),
                  // Login Button
                  GradientButton(
                    title: 'Log in',
                    textSize: 18,
                    svgIconPath: 'assets/icons/Double_right_arrow.svg',
                    iconSize: 20,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF3B82F6), Color(0xFF6366F1)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: 30,
                    height: 60,
                    width: 300,
                    onPressed: () => _handleLogin(context),
                  ),

                  const SizedBox(height: 16),

                  // Sign Up Redirect
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 16, color: Colors.black54),
                      children: [
                        const TextSpan(text: 'Didn’t have an account? '),
                        TextSpan(
                          text: 'Sign up',
                          style: const TextStyle(
                            color: AppColors.royalBlue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SignUpPage(selectedRole: widget.selectedRole),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  const Divider(height: 1, color: Colors.grey),
                  const SizedBox(height: 24),

                  // Social Logins
                  ...loginMethods.map(
                    (method) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: GradientOutlineButton(
                        title: method['title'],
                        gradientColors: method['colors'],
                        width: 320,
                        svgAssetPath: method['svgAssets'],
                        iconSize: 24,
                        onTap: () => _handleSocialLogin(method['method']),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Terms & Privacy
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(fontSize: 14, color: Colors.black54),
                        children: [
                          const TextSpan(text: 'By clicking continue, you agree to our '),
                          TextSpan(
                            text: 'Terms & Conditions',
                            style: const TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => print('Terms tapped'),
                          ),
                          const TextSpan(text: ' and acknowledge that you have read our '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: const TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => print('Privacy tapped'),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
