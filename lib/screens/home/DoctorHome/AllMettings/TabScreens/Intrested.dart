import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hiappy/widgets/Healpingbutton/button.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InterestedScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class InterestedScreen extends StatelessWidget {
  final List<Event> events = [
    Event(
      title: 'Stress management tips!',
      speaker: 'Dr. Dinesh Acharjya',
      specialization: 'Physical medicine & Rehabilitation',
      dateTime: DateTime(2024, 7, 20, 12, 45),
      duration: '30-45 min',
      imageUrl: 'https://static.vecteezy.com/system/resources/previews/011/411/660/non_2x/man-felling-depression-under-moral-stressful-sad-feel-guilty-need-attention-help-sitting-alone-vector.jpg',
      acceptLabel: 'Accept',
      declineLabel: 'Decline',
      acceptColors: [Colors.blue, Colors.lightBlueAccent],
      declineColors: [Colors.red, Colors.redAccent],
      onAccept: () => print('Accepted'),
    ),
    Event(
      title: 'Mindful Breathing',
      speaker: 'Dr. Priya Sharma',
      specialization: 'Clinical Psychologist',
      dateTime: DateTime.now().subtract(Duration(hours: 2)), // Already passed
      duration: '45-60 min',
      imageUrl: 'https://www.shutterstock.com/image-vector/depressed-boy-man-guy-sitting-600nw-2339323861.jpg',
      acceptLabel: 'Join',
      declineLabel: 'Skip',
      acceptColors: [Colors.green, Colors.lightGreen],
      declineColors: [Colors.orange],
      onAccept: () => print('Joined'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: events.length,
        itemBuilder: (context, index) => EventCard(event: events[index]),
      ),
    );
  }
}

class Event {
  final String title;
  final String speaker;
  final String specialization;
  final DateTime dateTime;
  final String duration;
  final String imageUrl;
  final String? acceptLabel;
  final String? declineLabel;
  final List<Color> acceptColors;
  final List<Color>? declineColors;
  final VoidCallback onAccept;

  Event({
    required this.title,
    required this.speaker,
    required this.specialization,
    required this.dateTime,
    required this.duration,
    required this.imageUrl,
    this.acceptLabel,
    this.declineLabel,
    required this.acceptColors,
    this.declineColors,
    required this.onAccept,
  });
}

class EventCard extends StatelessWidget {
  final Event event;

  EventCard({required this.event});

  bool get isExpired => event.dateTime.isBefore(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              event.imageUrl,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Topic & Via Zoom in a row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Topic', style: TextStyle(color: Colors.grey)),
                        SizedBox(height: 4),
                        Text(
                          event.title,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[700]),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.purple),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('Via Zoom',
                          style: TextStyle(color: Colors.purple)),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'Speaker: ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: event.speaker),
                    ],
                  ),
                ),
                Text(event.specialization),
                SizedBox(height: 12),

                // Date row using SVG
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/Time.svg', width: 16, color: Colors.blue),
                    SizedBox(width: 6),
                    Text(DateFormat('MMMM d, yyyy  hh:mm a').format(event.dateTime)),
                  ],
                ),
                SizedBox(height: 6),

                // Duration row using SVG
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/video_icon.svg', width: 16, color: Colors.blue),
                    SizedBox(width: 6),
                    Text(event.duration),
                  ],
                ),

                SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (isExpired)
                      // Show disabled gradient-style "Time is up" button
                      buildGradientButton(
                        onPressed: null,
                        gradientColors: [Color(0xFFB575EA), Color(0xFFEC758F)],
                        text: '01 : 20 : 26 hrs  REMAINING',

                      )
                    else
                      Row(
                        children: [
                          buildGradientButton(
                            onPressed: event.onAccept,
                            gradientColors: event.acceptColors,
                            text: event.acceptLabel ?? 'Accept',
                          ),
                          SizedBox(width: 10),
                          buildOutlinedButton(
                            borderColor: event.declineColors?.first ?? Colors.grey,
                            textColor: Colors.black,
                            text: event.declineLabel ?? 'Decline',
                          ),
                        ],
                      ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
