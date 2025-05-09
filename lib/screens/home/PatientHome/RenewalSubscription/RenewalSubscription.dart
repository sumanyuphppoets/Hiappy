import 'package:flutter/material.dart';
import 'package:hiappy/widgets/gradient_button.dart';

class RenewalSubscription extends StatelessWidget {
  const RenewalSubscription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6FAFF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Renewal Subscription',
          style: TextStyle(color: Colors.black87, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  // Placeholder for your image or illustration
                  SizedBox(
                    height: 200,
                    child: Image.asset(
                      'assets/images/Renewal.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Renewal For Subscription",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF5B8DEE),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Your subscription to Stay Sober is about to expire. Request for renewal now to continue enjoying the benefits.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: GradientButton(
                title: 'Request for renewal',
                textSize: 18,
                gradient: const LinearGradient(
                  colors: [Color(0xFF4D66E2), Color(0xFF3ABAEB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: 30,
                height: 100,
                width: 300,
                onPressed: () => (),
              ),
                  ),
          ],
        ),
      ),
    );
  }
}
