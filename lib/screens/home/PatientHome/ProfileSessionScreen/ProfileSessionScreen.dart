import 'package:flutter/material.dart';

class ProfileSessionScreen extends StatefulWidget {
  const ProfileSessionScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSessionScreen> createState() => _ProfileSessionScreenState();
}

class _ProfileSessionScreenState extends State<ProfileSessionScreen> {
  int _expandedIndex = -1; // No section expanded initially

  void _handleExpansion(int index) {
    setState(() {
      if (_expandedIndex == index) {
        _expandedIndex = -1; // Close if already open
      } else {
        _expandedIndex = index; // Open selected, close others
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildProfileCard(),
            const SizedBox(height: 20),
            _buildAccordionTile(
              index: 0,
              title: 'Personal Details',
              content: 'Here are your personal details...',
            ),
            _buildAccordionTile(
              index: 1,
              title: 'Rehab Center Details',
              content: 'Here are your rehab center details...',
            ),
            _buildAccordionTile(
              index: 2,
              title: 'Password',
              content: 'Change your password here...',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.only(top: 20, bottom: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF5DB9FF), Color(0xFF6E73FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  'https://randomuser.me/api/portraits/men/75.jpg', // Example image
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Nitin Kumar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Age: 28',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: const Icon(Icons.edit, color: Colors.white),
              onPressed: () {
                // Edit profile action
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccordionTile({
    required int index,
    required String title,
    required String content,
  }) {
    bool isExpanded = _expandedIndex == index;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ExpansionTile(
        initiallyExpanded: isExpanded,
        onExpansionChanged: (_) => _handleExpansion(index),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: const Icon(Icons.edit, color: Colors.grey),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(content),
          ),
        ],
      ),
    );
  }
}
