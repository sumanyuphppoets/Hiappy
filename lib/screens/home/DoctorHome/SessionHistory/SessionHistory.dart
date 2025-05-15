import 'package:flutter/material.dart';
import 'package:hiappy/widgets/CustomAppbar/PatientCustomAppbar.dart';
import 'package:hiappy/widgets/Searchcard/Searchcard.dart';

final List<Map<String, String>> sessionData = [
  {
    'imageUrl': 'assets/images/History_img.png',
    'title': 'Stress management tips!',
    'subtitle': 'Lorem ipsum dolor sit amet...',
    'duration': '45:12',
  },
  {
    'imageUrl': 'assets/images/History_img.png',
    'title': 'Stress management tips!',
    'subtitle': 'Lorem ipsum dolor sit amet...',
    'duration': '45:12',
  },
  {
    'imageUrl': 'assets/images/History_img.png',
    'title': 'Stress management tips!',
    'subtitle': 'Lorem ipsum dolor sit amet...',
    'duration': '45:12',
  },
  {
    'imageUrl': 'assets/images/History_img.png',
    'title': 'Stress management tips!',
    'subtitle': 'Lorem ipsum dolor sit amet...',
    'duration': '45:12',
  },
  {
    'imageUrl': 'assets/images/History_img.png',
    'title': 'Stress management tips!',
    'subtitle': 'Lorem ipsum dolor sit amet...',
    'duration': '45:12',
  },
  {
    'imageUrl': 'assets/images/History_img.png',
    'title': 'Stress management tips!',
    'subtitle': 'Lorem ipsum dolor sit amet...',
    'duration': '45:12',
  },
  {
    'imageUrl': 'assets/images/History_img.png',
    'title': 'Stress management tips!',
    'subtitle': 'Lorem ipsum dolor sit amet...',
    'duration': '45:12',
  },
  {
    'imageUrl': 'assets/images/History_img.png',
    'title': 'Stress management tips!',
    'subtitle': 'Lorem ipsum dolor sit amet...',
    'duration': '45:12',
  },
  {
    'imageUrl': 'assets/images/History_img.png',
    'title': 'Stress management tips!',
    'subtitle': 'Lorem ipsum dolor sit amet...',
    'duration': '45:12',
  },
];

final List<SessionHistoryItem> items =
    sessionData.map((data) {
      return SessionHistoryItem(
        imageUrl: data['imageUrl'] ?? '',
        title: data['title'] ?? '',
        subtitle: data['subtitle'] ?? '',
        duration: data['duration'] ?? '',
      );
    }).toList();

class SessionHistory extends StatelessWidget {
  const SessionHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SearchCardList(
                    titleText: 'Session History',
                    onSeeMore: () {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                          builder:
                              (BuildContext context) => const SessionHistory(),
                        ),
                      );
                    },
                    items: items,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
