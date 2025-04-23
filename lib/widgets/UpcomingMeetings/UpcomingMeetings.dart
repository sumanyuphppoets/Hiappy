import 'package:flutter/material.dart';
import 'package:hiappy/core/constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Meeting {
  final String topic;
  final String? imagePath;
  final String mentor;
  final DateTime dateTime;
  final String duration;
  final String platform;

  Meeting({
    required this.topic,
    this.imagePath,
    required this.mentor,
    required this.dateTime,
    required this.duration,
    required this.platform,
  });
}

class MeetingCard extends StatelessWidget {
  final Meeting meeting;
  final String? message;
  final String rescheduleText;
  final String? headingText;
  final String? seeMoreText;
  final String? titleText;

  final VoidCallback onCancel;
  final VoidCallback onReschedule;
  final VoidCallback? onSeeMore;

  final TextStyle? headingTextStyle;
  final TextStyle? seeMoreTextStyle;
  final TextStyle? topicTextStyle;
  final TextStyle? titleTextStyle;
  final TextStyle? mentorTextStyle;
  final TextStyle? detailTextStyle;
  final TextStyle? messageTextStyle;
  final ButtonStyle? cancelButtonStyle;
  final ButtonStyle? rescheduleButtonStyle;
  final TextStyle? rescheduleTextStyle;

  const MeetingCard({
    Key? key,
    required this.meeting,
    required this.rescheduleText,
    required this.onCancel,
    required this.onReschedule,
    this.message,
    this.headingText,
    this.seeMoreText,
    this.onSeeMore,
    this.titleText,
    this.headingTextStyle,
    this.seeMoreTextStyle,
    this.topicTextStyle,
    this.titleTextStyle,
    this.mentorTextStyle,
    this.detailTextStyle,
    this.messageTextStyle,
    this.cancelButtonStyle,
    this.rescheduleButtonStyle,
    this.rescheduleTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String displayImage = meeting.imagePath ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (headingText != null || (seeMoreText != null && onSeeMore != null))
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (headingText != null)
                  Text(
                    headingText!,
                    style: headingTextStyle ??
                        const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColors.black,
                        ),
                  ),
                if (seeMoreText != null && onSeeMore != null)
                  GestureDetector(
                    onTap: onSeeMore,
                    child: Text(
                      seeMoreText!,
                      style: seeMoreTextStyle ??
                          const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),
                    ),
                  ),
              ],
            ),
          ),
        if (headingText != null || (seeMoreText != null && onSeeMore != null))
          const SizedBox(height: 12),

        // Card Content
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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

              // Text content
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Topic and Platform
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            meeting.topic,
                            style: topicTextStyle ??
                                const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF007BFF),
                                ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            backgroundColor:
                                const Color(0xFFE6F0FF), // light blue background
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            meeting.platform,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF007BFF),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    if (titleText != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          titleText!,
                          maxLines: 2,
                          style: titleTextStyle ??
                              const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF666666),
                              ),
                        ),
                      ),

                    // Mentor
                    Text.rich(
                      TextSpan(
                        text: 'Mentor: ',
                        style: mentorTextStyle ??
                            const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                        children: [
                          TextSpan(
                            text: meeting.mentor,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Date
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 20,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${_formatDate(meeting.dateTime)}  ${_formatTime(meeting.dateTime)}',
                          style: detailTextStyle ??
                              const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Duration
                    Row(
                      children: [
                        const Icon(
                          Icons.videocam,
                          size: 20,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          meeting.duration,
                          style: detailTextStyle ??
                              const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),

                    if (message != null && message!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          message!,
                          style: messageTextStyle ??
                              const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.green,
                              ),
                        ),
                      ),
                  ],
                ),
              ),

              // Buttons
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: onCancel,
                      style: cancelButtonStyle ??
                          OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF007BFF)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: onReschedule,
                      style: rescheduleButtonStyle ??
                          ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF007BFF), Color(0xFF00C6FF)],
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          alignment: Alignment.center,
                          child: Text(
                            rescheduleText,
                            style: rescheduleTextStyle ??
                                const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }

  static String _formatDate(DateTime dateTime) {
    return '${_monthName(dateTime.month)} ${dateTime.day}, ${dateTime.year}';
  }

  static String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final period = dateTime.hour >= 12 ? 'pm' : 'am';
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }

  static String _monthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return months[month - 1];
  }
}
