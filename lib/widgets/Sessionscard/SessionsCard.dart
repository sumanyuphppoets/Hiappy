import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hiappy/core/constants/colors.dart';

class SessionsCard extends StatelessWidget {
  final String? imagePath;
  final String? topic;
  final String? time;
  final String? speaker;
  final String? subtitle;
  final String? message;
  final String? duration;
  final String? buttonText;
  final int? joinedCount;
  final List<String>? joinedAvatars;
  final String? headingText;
  final String? seeMoreText;
  final VoidCallback? onSeeMore;

  const SessionsCard({
    super.key,
    this.imagePath,
    this.topic,
    this.time,
    this.speaker,
    this.subtitle,
    this.message,
    this.duration,
    this.buttonText,
    this.joinedCount,
    this.joinedAvatars,
    this.headingText,
    this.seeMoreText,
    this.onSeeMore,
  });

  @override
  Widget build(BuildContext context) {
    final displayImage = imagePath ?? '';
    final displayTopic = topic ?? '';
    final displayTime = time ?? '';
    final displaySpeaker = speaker ?? '';
    final displaySubtitle = subtitle ?? '';
    final displayMessage = message ?? '';
    final displayDuration = duration ?? '';
    final displayButtonText = buttonText ?? 'Join now';
    final displayJoinedCount = joinedCount ?? 0;
    final displayAvatars = joinedAvatars ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if ((headingText?.isNotEmpty ?? false) || (seeMoreText?.isNotEmpty ?? false))
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
                    // RIGHT SIDE: Time + Avatars
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (displayTime.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  size: 14,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  displayTime,
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 12),
                        if (displayAvatars.isNotEmpty && displayJoinedCount > 0)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: (displayAvatars.length * 25).toDouble(),
                                height: 32,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: displayAvatars.asMap().entries.map((entry) {
                                    int index = entry.key;
                                    String avatar = entry.value;
                                    return Positioned(
                                      left: (index * 20).toDouble(),
                                      child: CircleAvatar(
                                        radius: 16,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: 14,
                                          backgroundImage: AssetImage(avatar),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '$displayJoinedCount+ Join',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF3D5CFF), Color(0xFF00B4DB)],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(1.5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 10,
                          ),
                          child: Text(
                            displayButtonText,
                            style: const TextStyle(
                              color: Color(0xFF3D5CFF),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
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
