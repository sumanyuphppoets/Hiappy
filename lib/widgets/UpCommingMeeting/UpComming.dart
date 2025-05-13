import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hiappy/core/constants/colors.dart';
import 'package:hiappy/widgets/gradient_button.dart';

class UpComming extends StatelessWidget {
  final String? imagePath;
  final String? topic;
  final String? speaker;
  final String? subtitle;
  final String? message;
  final String? duration;
  final String? buttonText;
  final String? headingText;
  final String? seeMoreText;
  final VoidCallback? onSeeMore;
  final String? platform;
  final String? Join;

  const UpComming({
    super.key,
    this.imagePath,
    this.topic,
    this.speaker,
    this.subtitle,
    this.message,
    this.duration,
    this.buttonText,
    this.headingText,
    this.seeMoreText,
    this.onSeeMore,
    this.platform,
    this.Join,
  });

  @override
  Widget build(BuildContext context) {
    final displayImage = imagePath ?? '';
    final displayTopic = topic ?? '';
    final displaySpeaker = speaker ?? '';
    final displaySubtitle = subtitle ?? '';
    final displayMessage = message ?? '';
    final displayDuration = duration ?? '';
    final displayButtonText = buttonText ?? '';
    final JoinButtonText = Join ?? 'Join now';
    final displayPlatform = platform ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if ((headingText?.isNotEmpty ?? false) ||
            (seeMoreText?.isNotEmpty ?? false))
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (headingText?.isNotEmpty ?? false)
                  Text(
                    headingText!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (seeMoreText?.isNotEmpty ?? false)
                  TextButton(
                    onPressed: onSeeMore,
                    child: Text(
                      seeMoreText!,
                      style: const TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        Container(
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (displayImage.isNotEmpty)
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: Image.asset(
                    displayImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // LEFT SIDE: Text Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (displayTopic.isNotEmpty)
                            Text(
                              displayTopic,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          const SizedBox(height: 10),
                          if (displaySubtitle.isNotEmpty)
                            Text(
                              displaySubtitle,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                          const SizedBox(height: 6),
                          if (displaySpeaker.isNotEmpty)
                            Text.rich(
                              TextSpan(
                                text: 'Speaker: ',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black87,
                                ),
                                children: [
                                  TextSpan(
                                    text: displaySpeaker,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(height: 4),
                          if (displayMessage.isNotEmpty)
                            Text(
                              displayMessage,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                            ),
                        ],
                      ),
                    ),
                    // RIGHT SIDE: Platform Tag
                    if (displayPlatform.isNotEmpty)
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFEB77CA), Color(0xFF968FFB)],
                            // Your gradient colors
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(1.5), // Border thickness
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white, // White background
                            borderRadius: BorderRadius.circular(
                              18,
                            ), // Slightly less radius
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: ShaderMask(
                            shaderCallback:
                                (bounds) => const LinearGradient(
                                  colors: [
                                    Color(0xFFEB77CA),
                                    Color(0xFF968FFB),
                                  ],
                                ).createShader(
                                  Rect.fromLTWH(
                                    0,
                                    0,
                                    bounds.width,
                                    bounds.height,
                                  ),
                                ),
                            child: Text(
                              displayPlatform,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color:
                                    Colors
                                        .white, // Required but will be overridden by ShaderMask
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    if (displayDuration.isNotEmpty)
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/video_icon.svg',
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            displayDuration,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: GradientButton(
                        title: displayButtonText,
                        textSize: 12,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF75B5EB), Color(0xFF75EC99)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: 30,
                        height: 50,
                        width: 150,
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(1.5),
                      child: GradientButton(
                        title: JoinButtonText,
                        textSize: 12,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF3ABAEB), Color(0xFF4D66E2)],
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                        ),
                        borderRadius: 30,
                        height: 50,
                        width: 150,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
