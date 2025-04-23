import 'package:flutter/material.dart';
import 'package:hiappy/core/constants/colors.dart';
import 'package:hiappy/widgets/title_text.dart';

class MentorCard extends StatelessWidget {
  final String name;
  final String profession;
  final String image;
  final VoidCallback onCreateMeeting;
  final VoidCallback onCallNow;
  final String createBtnText;
  final String callBtnText;

  const MentorCard({
    Key? key,
    this.name = '',
    this.profession = '',
    this.image = '',
    this.onCreateMeeting = _defaultAction,
    this.onCallNow = _defaultAction,
    this.createBtnText = 'Create meeting',
    this.callBtnText = 'Call now',
  }) : super(key: key);

  static void _defaultAction() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20), // Responsive padding
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5FAFD),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(radius: 50,  backgroundImage: AssetImage(image),),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleText(
                      text: name,
                      textAlign: TextAlign.left,
                      fontSize: 16,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 4),
                    TitleText(
                      text: profession,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: AppColors.darkGrey,
                      maxLines: 2,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Create Meeting Button with Gradient
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF75B5EB), Color(0xFF75EC99)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ElevatedButton(
                      onPressed: onCreateMeeting,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: TitleText(
                        text: createBtnText,
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Call Now Button with Gradient
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4D66E2), Color(0xFF3ABAEB)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ElevatedButton(
                      onPressed: onCallNow,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: TitleText(
                        text: callBtnText,
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
