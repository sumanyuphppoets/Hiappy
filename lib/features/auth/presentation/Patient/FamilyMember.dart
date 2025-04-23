import 'package:flutter/material.dart';
import 'package:hiappy/core/constants/colors.dart';
import 'package:hiappy/features/auth/presentation/Patient/FamilyMemberProfile.dart';
import 'package:hiappy/widgets/CustomInput.dart';
import 'package:hiappy/widgets/gradient_button.dart';

class FamilyMemberScreen extends StatefulWidget {
  const FamilyMemberScreen({Key? key}) : super(key: key);

  @override
  State<FamilyMemberScreen> createState() => _FamilyMemberScreenState();
}

class _FamilyMemberScreenState extends State<FamilyMemberScreen> {
  final List<Map<String, TextEditingController>> _familyControllers = [
    {
      'name': TextEditingController(),
      'email': TextEditingController(),
      'phone': TextEditingController(),
    },
  ];

  final _formKey = GlobalKey<FormState>();

  void _addFamilyMember() {
    setState(() {
      _familyControllers.add({
        'name': TextEditingController(),
        'email': TextEditingController(),
        'phone': TextEditingController(),
      });
    });
  }

  void _removeFamilyMember(int index) {
    if (_familyControllers.length > 1) {
      setState(() {
        _familyControllers.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.asset('assets/images/splash_screen_logo.png', height: 80),
              const SizedBox(height: 10),
              const Text(
                'Sign up with Email',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5),
              const Text(
                'Family member details',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF3B82F6),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      ..._familyControllers.asMap().entries.map((entry) {
                        int index = entry.key;
                        var controllers = entry.value;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.white),
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      CustomInput(
                                        hint: 'Full name',
                                        iconAsset: 'assets/icons/Name.svg',
                                        controller: controllers['name']!,
                                        iconSize: 15,
                                        validator:
                                            (value) =>
                                                value == null || value.isEmpty
                                                    ? ''
                                                    : null,
                                      ),
                                      const SizedBox(height: 10),
                                      CustomInput(
                                        hint: 'Email',
                                        iconAsset:
                                            'assets/icons/Email_Hiappy.svg',
                                        controller: controllers['email']!,
                                        iconSize: 15,
                                        validator:
                                            (value) =>
                                                value == null || value.isEmpty
                                                    ? ''
                                                    : null,
                                      ),
                                      const SizedBox(height: 10),
                                      CustomInput(
                                        hint: 'Phone number',
                                        iconAsset:
                                            'assets/icons/Phone_Number.svg',
                                        controller: controllers['phone']!,
                                        iconSize: 15,
                                        validator:
                                            (value) =>
                                                value == null || value.isEmpty
                                                    ? ''
                                                    : null,
                                      ),
                                    ],
                                  ),
                                ),
                                if (index != 0)
                                  Positioned(
                                    top: -15,
                                    right: 0,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                      onPressed:
                                          () => _removeFamilyMember(index),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: _addFamilyMember,
                        child: Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF5F63DC), Color(0xFF3ABCEC)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),

                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Text(
                              'Add More',

                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 200),
                      GradientButton(
                        title: 'Next',
                        textSize: 18,
                        svgIconPath: 'assets/icons/Double_right_arrow.svg',
                        iconSize: 20,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF5F63DC), Color(0xFF3ABCEC)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: 30,
                        height: 60,
                        width: 300,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print('Form valid: proceed');
                            {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const FamilyMemberProfile(),
                                ),
                              );
                            }
                          } else {
                            print('Validation failed');
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
