import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hiappy/features/auth/presentation/Patient/FamilyMember.dart';
import 'package:hiappy/features/auth/presentation/thank_you_screen.dart';
import 'package:hiappy/widgets/gradient_button.dart';

class OTPScreen extends StatefulWidget {
  final String selectedRole;
  const OTPScreen({Key? key, required this.selectedRole}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());
  List<TextEditingController> controllers = List.generate(4, (_) => TextEditingController());

  int secondsRemaining = 60;
  late final Timer timer;

  String generatedOtp = '';

  @override
  void initState() {
    super.initState();
    generateDummyOtp();
    startTimer();
  }

  void generateDummyOtp() {
    final random = Random();
    generatedOtp = List.generate(4, (_) => random.nextInt(10)).join();
    print('🔐 Dummy OTP for testing: $generatedOtp');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Dummy OTP: $generatedOtp'),
          duration: const Duration(seconds: 4),
        ),
      );
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() {
          secondsRemaining--;
        });
      }
    });
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    timer.cancel();
    super.dispose();
  }

  void onOtpChanged(int index, String value) {
    if (value.isNotEmpty && index < 3) {
      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
    }
  }

  void handleSubmit() {
    final enteredOtp = controllers.map((c) => c.text).join();

    if (enteredOtp == generatedOtp) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ OTP Verified Successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ThankYouScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('❌ Invalid OTP. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAFF),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(child: Image.asset('assets/images/splash_screen_logo.png', height: 80)),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24 ,vertical: 50),
                child: Column(
                  children: [
                    const SizedBox(height: 70),
                    Text(
                      'OTP Verification',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'We already sent an OTP code on your\nEmail: example@gmail.com',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(4, (index) {
                        return SizedBox(
                          width: 50,
                          child: TextField(
                            controller: controllers[index],
                            focusNode: focusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            style: const TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              counterText: '',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.blueAccent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.green),
                              ),
                            ),
                            onChanged: (value) => onOtpChanged(index, value),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      secondsRemaining > 0
                          ? '00:${secondsRemaining.toString().padLeft(2, '0')} min'
                          : 'Time expired',
                      style: const TextStyle(
                        color: Colors.purple,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: secondsRemaining == 0
                          ? () {
                              setState(() {
                                secondsRemaining = 60;
                                generateDummyOtp();
                                startTimer();
                              });
                            }
                          : null,
                      child: Text(
                        "Didn't get any code? Resend",
                        style: TextStyle(
                          color: secondsRemaining == 0 ? Colors.blue : Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: GradientButton(
                title: 'Submit',
                borderRadius: 30,
                height: 60,
                width: 300,
                textSize: 16,
                svgIconPath: 'assets/icons/Double_right_arrow.svg',
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF10B981)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                onPressed: handleSubmit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
