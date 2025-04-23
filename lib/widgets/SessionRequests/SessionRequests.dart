import 'package:flutter/material.dart';

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
  final List<SessionData> sessions;
  final void Function(SessionData session) onAccept;
  final void Function(SessionData session) onReject;

  const SessionRequests({
    Key? key,
    required this.sessions,
    required this.onAccept,
    required this.onReject,
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
        /// Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Session Requests (${widget.sessions.length.toString().padLeft(2, '0')})",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                "See more",
                style: TextStyle(
                    color: Colors.blue.shade600, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),

        /// Slider
        SizedBox(
          height: 260,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: widget.sessions.length,
            itemBuilder: (context, index) {
              return _buildSessionCard(widget.sessions[index]);
            },
          ),
        ),

        /// Dots Indicator
        const SizedBox(height: 12),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.sessions.length, (index) {
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
                      padding: const EdgeInsets.all(
                        1.5,
                      ), // Thickness of the border
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
                _buildOutlinedButton("Reject", Colors.blue, () => widget.onReject(session)),
                _buildGradientButton("Accept", () => widget.onAccept(session)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOutlinedButton(String text, Color color, VoidCallback onPressed) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Text(text, style: TextStyle(color: color)),
    );
  }

  Widget _buildGradientButton(String text, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF56CCF2), Color(0xFF2F80ED)]),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: Text(text),
      ),
    );
  }
}
