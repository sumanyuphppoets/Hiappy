import 'package:flutter/material.dart';
import 'package:hiappy/widgets/title_text.dart';

class TermsofService extends StatelessWidget {
  const TermsofService({Key? key}) : super(key: key);

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
                text: "Terms of Services",
                fontSize: 18,
                color: Colors.black,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),

            Center(
              child: TitleText(
                text: "Last update: October 13, 2023",
                fontSize: 14,
                color: Colors.black45,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),

            // Left-aligned Paragraphs
            const TitleText(
              text:
                  "Lorem ipsum dolor sit amet consectetur. Pellentesque morbi aliquam condimentum dui. Sed volutpat dui sit eget et. Feugiat in scelerisque et volutpat odio. Sed gravida tortor accumsan morbi bibendum in sit.",
              fontSize: 14,
              color: Colors.black87,
              textAlign: TextAlign.left,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(height: 20),

            const TitleText(
              text: "Lorem ipsum dolor",
              fontSize: 16,
              color: Colors.black,
              textAlign: TextAlign.left,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 10),

            const TitleText(
              text:
                  "Lorem ipsum dolor sit amet consectetur. Pellentesque morbi aliquam condimentum dui. Sed volutpat dui sit eget et. Feugiat in scelerisque et volutpat odio. Sed gravida tortor accumsan morbi bibendum in sit.",
              fontSize: 14,
              color: Colors.black87,
              textAlign: TextAlign.left,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(height: 20),

            const TitleText(
              text:
                  "Lorem ipsum dolor sit amet consectetur. Pellentesque morbi aliquam condimentum dui. Sed volutpat dui sit eget et. Feugiat in scelerisque et volutpat odio. Sed gravida tortor accumsan morbi bibendum in sit.",
              fontSize: 14,
              color: Colors.black87,
              textAlign: TextAlign.left,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(height: 20),

            const TitleText(
              text: "Lorem ipsum dolor",
              fontSize: 16,
              color: Colors.black,
              textAlign: TextAlign.left,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 10),

            const TitleText(
              text:
                  "Lorem ipsum dolor sit amet consectetur. Pellentesque morbi aliquam condimentum dui. Sed volutpat dui sit eget et. Feugiat in scelerisque et volutpat odio. Sed gravida tortor accumsan morbi bibendum in sit.",
              fontSize: 14,
              color: Colors.black87,
              textAlign: TextAlign.left,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(height: 20),

            const TitleText(
              text: "Lorem ipsum dolor",
              fontSize: 16,
              color: Colors.black,
              textAlign: TextAlign.left,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 10),

            const TitleText(
              text:
                  "Lorem ipsum dolor sit amet consectetur. Pellentesque morbi aliquam condimentum dui. Sed volutpat dui sit eget et. Feugiat in scelerisque et volutpat odio. Sed gravida tortor accumsan morbi bibendum in sit.",
              fontSize: 14,
              color: Colors.black87,
              textAlign: TextAlign.left,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
