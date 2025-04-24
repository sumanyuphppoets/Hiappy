import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hiappy/core/constants/colors.dart';
import 'package:hiappy/widgets/Healpingbutton/button.dart';
import 'package:hiappy/widgets/title_text.dart';

class Invitation {
  final String? title;
  final String? speaker;
  final DateTime? dateTime;
  final String? duration;
  final String? imagePath;
  final Gradient? gradientBackground;
final Gradient? gradientBorder;

  final VoidCallback? onAccept;
  final VoidCallback? onDecline;

  final String? acceptLabel;
  final String? declineLabel;

  final TextStyle? titleStyle;
  final TextStyle? speakerStyle;
  final TextStyle? dateStyle;
  final TextStyle? durationStyle;

  final List<Color>? acceptColors;
  final List<Color>? declineColors;

  Invitation({
    this.title,
    this.speaker,
    this.dateTime,
    this.duration,
    this.imagePath,
    this.onAccept,
    this.onDecline,
    this.acceptLabel,
    this.declineLabel,
    this.titleStyle,
    this.speakerStyle,
    this.dateStyle,
    this.durationStyle,
    this.acceptColors,
    this.declineColors,
    this.gradientBackground,
  this.gradientBorder,
  
  });
}

class InvitationsList extends StatelessWidget {
  final List<Invitation> invitations;
  final String? seeMoreLabel;
  final VoidCallback? onSeeMorePressed;

  const InvitationsList({
    super.key,
    required this.invitations,
    this.seeMoreLabel,
    this.onSeeMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (invitations.isNotEmpty && seeMoreLabel != null && onSeeMorePressed != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Invitations (${invitations.length.toString().padLeft(2, '0')})',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: onSeeMorePressed,
                  child: Text(
                    seeMoreLabel!,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ...invitations.map((inv) => InvitationCard(invitation: inv)).toList(),
      ],
    );
  }
}

class InvitationCard extends StatelessWidget {
  final Invitation invitation;

  const InvitationCard({super.key, required this.invitation});

  static String _formatDate(DateTime dateTime) {
    return '${_monthName(dateTime.month)} ${dateTime.day}, ${dateTime.year}';
  }

  static String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'pm' : 'am';
    return '$hour:$minute $period';
  }

  static String _monthName(int month) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month];
  }


  @override
  Widget build(BuildContext context) {
    String? formattedDateTime;
    if (invitation.dateTime != null) {
      formattedDateTime =
          '${_formatDate(invitation.dateTime!)}  ${_formatTime(invitation.dateTime!)}';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
      child: IntrinsicHeight(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (invitation.imagePath != null)
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                  child: Image.asset(
                    invitation.imagePath!,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (invitation.title != null)
                        Text(
                          invitation.title!,
                          style: invitation.titleStyle ??
                              const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF007BFF),
                              ),
                        ),
                      if (invitation.speaker != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Speaker: ${invitation.speaker}',
                          style: invitation.speakerStyle ??
                              const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                        ),
                      ],
                      if (formattedDateTime != null) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/DateSelect.svg',
                              height: 16,
                              width: 16,
                              colorFilter: const ColorFilter.mode(
                                Colors.blue,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(width: 4),
                            TitleText(text: formattedDateTime, fontSize: 13),
                          ],
                        ),
                      ],
                      if (invitation.duration != null) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/Video.svg',
                              height: 16,
                              width: 16,
                              colorFilter: const ColorFilter.mode(
                                Colors.blue,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              invitation.duration!,
                              style: invitation.durationStyle ??
                                  const TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        
                        children: [
                          
                          if (invitation.onDecline != null)
                          invitation.declineColors != null &&
                                    invitation.declineColors!.isNotEmpty ?
                            buildOutlinedButton(
                              borderColor: invitation.declineColors?.first,
                              textColor: AppColors.info,
                              text: invitation.declineLabel ?? 'Decline',
                            )
                          
                          :  TextButton(
                              onPressed: invitation.onDecline,
                              child: Text(
                                invitation.declineLabel ?? 'Decline',
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          if (invitation.onAccept != null)
                            const SizedBox(width: 8),
                          if (invitation.onAccept != null)
                            invitation.acceptColors != null &&
                                    invitation.acceptColors!.isNotEmpty
                                ? buildGradientButton(
                                    onPressed: invitation.onAccept,
                                    gradientColors: invitation.acceptColors,
                                    text: invitation.acceptLabel ?? 'Accept',
                                  )
                                : TextButton(
                                    onPressed: invitation.onAccept,
                                    child: Text(
                                      invitation.acceptLabel ?? 'Accept',
                                      style: const TextStyle(
                                        color: Color(0xFF007BFF),
                                      ),
                                    ),
                                  ),
                        ],
                      )
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
