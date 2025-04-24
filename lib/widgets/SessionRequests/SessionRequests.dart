import 'package:flutter/material.dart';
import 'package:hiappy/core/constants/colors.dart';
import 'package:hiappy/widgets/Healpingbutton/button.dart';

class SessionData {
  final String topic;
  final String createdBy;
  final String date;
  final String time;
  final String duration;
  final String mode;

  SessionData({
    required this.topic,
    required this.createdBy,
    required this.date,
    required this.time,
    required this.duration,
    required this.mode,
  });
}

class SessionRequests extends StatefulWidget {
  final List<SessionData>? sessions; // Optional, may be null
  final void Function(SessionData)? onAccept; // Optional callback function
  final void Function(SessionData)? onReject; // Optional callback function
  final String? headerText; // Optional dynamic header text
  final String? actionText; // Optional dynamic action text
  final VoidCallback? onActionClick; // Optional dynamic clickable function
  final String? acceptButtonText; // Optional dynamic text for the accept button
  final String? rejectButtonText; // Optional dynamic text for the reject button


  const SessionRequests({
    Key? key,
    this.sessions, // Nullable list of sessions
    this.onAccept, // Nullable accept callback
    this.onReject, // Nullable reject callback
    this.headerText, // Nullable header text
    this.actionText, // Nullable action text
    this.onActionClick, // Nullable action callback
    this.acceptButtonText, // Nullable dynamic accept button text
    this.rejectButtonText, // Nullable dynamic reject button text
  }) : super(key: key);

  @override
  State<SessionRequests> createState() => _SessionRequestsState();
}

class _SessionRequestsState extends State<SessionRequests> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header with dynamic text (conditionally render if headerText is provided)
        if (widget.headerText != null && widget.sessions != null && widget.sessions!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.headerText} (${widget.sessions!.length.toString().padLeft(2, '0')})", // Use dynamic header text
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                // Conditionally render the action text if it's available and the onActionClick is provided
                if (widget.actionText != null && widget.onActionClick != null)
                  GestureDetector(
                    onTap: widget.onActionClick, // Trigger the dynamic action
                    child: Text(
                      widget.actionText!, // Use dynamic action text
                      style: TextStyle(
                          color: Colors.blue.shade600, fontWeight: FontWeight.w500),
                    ),
                  ),
              ],
            ),
          ),

        /// Slider (conditionally render if sessions are available)
        if (widget.sessions != null && widget.sessions!.isNotEmpty)
          SizedBox(
            height: 260,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: widget.sessions!.length,
              itemBuilder: (context, index) {
                return _buildSessionCard(widget.sessions![index]);
              },
            ),
          ),

        /// Dots Indicator (conditionally render if sessions are available)
        if (widget.sessions != null && widget.sessions!.isNotEmpty)
          const SizedBox(height: 12),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.sessions?.length ?? 0, (index) {
                bool isActive = _currentIndex == index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: isActive ? 24 : 8,
                  decoration: BoxDecoration(
                    color: isActive ? Colors.blue : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                );
              }),
            ),
          ),
      ],
    );
  }

  Widget _buildSessionCard(SessionData session) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: Colors.grey.shade200,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Topic and Tag
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Topic", style: TextStyle(color: Colors.grey)),
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFEB77CA), Color(0xFF968FFB)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(1.5), // Thickness of the border
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Text(
                      'Via Zoom',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF8A2BE2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            Text(
              session.topic,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600, color: Colors.blue),
            ),
            const SizedBox(height: 4),
            Text(
              "Created by: ${session.createdBy}",
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.blue),
                const SizedBox(width: 6),
                Text("${session.date}   ${session.time}"),
              ],
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                const Icon(Icons.video_call, size: 16, color: Colors.blue),
                const SizedBox(width: 6),
                Text(session.duration),
              ],
            ),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildOutlinedButton(
              text: widget.rejectButtonText ?? "Reject",
              textColor: Colors.blue,
              borderColor: Colors.blue,
              onPressed: () {
                if (widget.onReject != null) {
                  widget.onReject!(session);
                }
              },
            ),
                buildGradientButton(
              text: widget.acceptButtonText ?? "Accept",
            gradientColors: [AppColors.lightBlue, AppColors.darkeBlue],
              onPressed: () {
                if (widget.onAccept != null) {
                  widget.onAccept!(session);
                }
              },
            ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
