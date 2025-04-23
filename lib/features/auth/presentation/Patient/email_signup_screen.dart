import 'package:flutter/material.dart';
import 'package:hiappy/core/constants/colors.dart';
import 'package:hiappy/features/auth/presentation/otp_screen.dart';
import 'package:hiappy/features/auth/services/auth_service.dart';
import 'package:hiappy/widgets/CustomInput.dart';
import 'package:hiappy/widgets/gradient_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EmailSignupScreen extends StatefulWidget {
  @override
  State<EmailSignupScreen> createState() => _EmailSignupScreenState();
  final String selectedRole;
  final String? name;
  final String? phone;
  final String? email;
  final String? method;
  EmailSignupScreen({super.key, required this.selectedRole, this.name, this.phone, this.email, this.method});
}

class _EmailSignupScreenState extends State<EmailSignupScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    fullNameController = TextEditingController(text: widget.name ?? '');
    emailController = TextEditingController(text: widget.email ?? '');
    phoneNumberController = TextEditingController(text: widget.phone ?? '');
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // API call for signup
  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
    final result = await AuthService.signup({
        'fullName': fullNameController.text,
        'email': emailController.text,
        'phone': phoneNumberController.text,
        'password': passwordController.text,
        'confirmPassword': confirmPasswordController.text,
        'role': widget.selectedRole,
      });

    if (result['success']) {
        // Navigate to OTP screen on successful signup
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => OTPScreen(
              selectedRole: widget.selectedRole,
            ),
          ),
        );
      } else {
        // Show error message if signup fails
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(result['error']),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Close'),
              ),
            ],
          ),
        );
      }
    } else {
      debugPrint('Form is not valid.');
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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/splash_screen_logo.png', height: 80),
                  const SizedBox(height: 20),
                  Text(
                    'Sign up with ${widget.method}',
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Personal details',
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.royalBlue,
                    ),
                  ),
                  const SizedBox(height: 50),

                  // Form fields with red border only validation
                  CustomInput(
                    hint: 'Full name',
                    iconAsset: 'assets/icons/Name.svg',
                    controller: fullNameController,
                    iconSize: 15,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return '';
                      }
                      return null;
                    },
                  ),
                  CustomInput(
                    hint: 'Email',
                    iconAsset: 'assets/icons/Email_Hiappy.svg',
                    controller: emailController,
                    iconSize: 15,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return '';
                      }
                      return null;
                    },
                  ),
                  CustomInput(
                    hint: 'Phone number',
                    iconAsset: 'assets/icons/Phone_Number.svg',
                    controller: phoneNumberController,
                    iconSize: 15,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return '';
                      }
                      return null;
                    },
                  ),
                  CustomInput(
                    hint: 'Password',
                    iconAsset: 'assets/icons/Password.svg',
                    controller: passwordController,
                    iconSize: 15,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                  ),
                  CustomInput(
                    hint: 'Confirm password',
                    iconAsset: 'assets/icons/Password.svg',
                    controller: confirmPasswordController,
                    iconSize: 15,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '';
                      }
                      if (value != passwordController.text) {
                        return '';
                      }
                      return null;
                    },
                  ),

                  GradientButton(
                    title: 'Sign up',
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
                    onPressed: () {_signup();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
