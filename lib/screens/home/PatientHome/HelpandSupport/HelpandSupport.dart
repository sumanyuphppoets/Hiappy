import 'package:flutter/material.dart';
import 'package:hiappy/widgets/gradient_outline_button.dart';
import 'package:hiappy/widgets/title_text.dart';

class HelpandSupport extends StatelessWidget {
  const HelpandSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/splash_screen_logo.png',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Centered Heading
            Center(
              child: TitleText(
                text: "Help & Support Center",
                fontSize: 18,
                color: Colors.black,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: GradientOutlineButton(
                title: 'Contact Support',
                gradientColors: const [Color(0xFF75B5EB), Color(0xFF75EC99)],
                width: 320,
                iconSize: 24,
                onTap: () => (),
              ),
            ),
            Center(
              child: GradientOutlineButton(
                title: 'Profile & Billing',
                gradientColors: const [Color(0xFF75E9F0), Color(0xFF757CF0)],
                width: 320,
                iconSize: 24,
                onTap: () => (),
              ),
            ),
            Center(
              child: GradientOutlineButton(
                title: 'Using The App',
                gradientColors: const [Color(0xFFEB77CA), Color(0xFF968FFB)],
                width: 320,
                iconSize: 24,
                onTap: () => (),
              ),
            ),
            Center(
              child: GradientOutlineButton(
                title: 'Learn About Stay Sober',
                gradientColors: const [Color(0xFF75E9F0), Color(0xFF757CF0)],
                width: 320,
                iconSize: 24,
                onTap: () => (),
              ),
            ),
            const SizedBox(height: 20),
            const TitleText(
              text: "Related Articles",
              fontSize: 18,
              color: Colors.black,
              textAlign: TextAlign.left,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 10),

            const TitleText(
              text:
                  "sit amet consectetur. Pellentesque morbi aliquam condimentum dui. ",
              fontSize: 14,
              color: Colors.black87,
              textAlign: TextAlign.left,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 10),
            Divider(thickness: 0.5, color: Colors.grey),
            SizedBox(height: 10),
            const TitleText(
              text:
                  "sit amet consectetur. Pellentesque morbi aliquam condimentum dui. ",
              fontSize: 14,
              color: Colors.black87,
              textAlign: TextAlign.left,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 10),
            Divider(thickness: 0.5, color: Colors.grey),
            SizedBox(height: 10),
            const TitleText(
              text:
                  "sit amet consectetur. Pellentesque morbi aliquam condimentum dui. ",
              fontSize: 14,
              color: Colors.black87,
              textAlign: TextAlign.left,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 10),
            Divider(thickness: 0.5, color: Colors.grey),
            SizedBox(height: 10),
            const TitleText(
              text:
                  "sit amet consectetur. Pellentesque morbi aliquam condimentum dui. ",
              fontSize: 14,
              color: Colors.black87,
              textAlign: TextAlign.left,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 10),
            Divider(thickness: 0.5, color: Colors.grey),
            SizedBox(height: 10),
            const TitleText(
              text:
                  "sit amet consectetur. Pellentesque morbi aliquam condimentum dui. ",
              fontSize: 14,
              color: Colors.black87,
              textAlign: TextAlign.left,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
