import 'package:flutter/material.dart';
import 'package:hiappy/widgets/CustomInput.dart';

class EditAccount extends StatelessWidget {
  const EditAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allows gradient to show behind AppBar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Image.asset(
          'assets/images/StaySoberLogo.png', // Your image path
          height: 50,
          fit: BoxFit.contain,
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4D66E2), Color(0xFF3ABAEB)],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
        ),
        padding: const EdgeInsets.fromLTRB(24, 140, 24, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            const Center(
              child: Text(
                'Update Your Account Details',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 30),
            CustomInput(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade100,
                hintText: "Full name",
                contentPadding: const EdgeInsets.all(20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
              ),
              hint: 'Full name',
            ),
            const SizedBox(height: 16),
            CustomInput(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade100,
                hintText: "Email",
                contentPadding: const EdgeInsets.all(20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
              ),
              hint: 'Email',
            ),
            const SizedBox(height: 16),
           CustomInput(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade100,
                hintText: "Phone number",
                
                contentPadding: const EdgeInsets.all(20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
              ),
              hint: 'Phone number',
            ),
            const Spacer(),
            Center(
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF56CCF2), Color(0xFF2F80ED)],
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    // Save logic
                  },
                  child: const Text(
                    'Save updates',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
