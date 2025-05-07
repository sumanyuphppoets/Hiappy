import 'package:flutter/material.dart';
import 'package:hiappy/core/constants/colors.dart';
import 'package:hiappy/widgets/CustomAccordion/CustomAccordion.dart';

class ProfileSessionScreen extends StatelessWidget {
  const ProfileSessionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sections = [
      {
        'title': 'Personal Details',
        'items': [
          {
            'label': 'Email',
            'value': 'myaddress@mail.com',
            'iconSvg': 'assets/icons/profile_email.svg',
          },
          {
            'label': 'Phone Number',
            'value': '+91 7014132321',
            'iconSvg': 'assets/icons/Profile_number.svg',
          },
          {
            'label': 'Date of Birth',
            'value': '19/09/1995',
            'iconSvg': 'assets/icons/Date_of_Birth.svg',
          },
          {
            'label': 'Gender',
            'value': 'Male',
            'iconSvg': 'assets/icons/Gender.svg',
          },
          {
            'label': 'Emergency Contact',
            'value': '+91 xxxx-xxxxxx',
            'iconSvg': 'assets/icons/Profile_number.svg',
          },
          {
            'label': 'Home Address',
            'value': 'Shyam Lal Rd, Daryaganj, Delhi',
            'iconSvg': 'assets/icons/Profile_location.svg',
          },
        ],
      },
      {
        'title': 'Rehab Center Details',
        'items': [
          {
            'label': 'Rehab Center Name',
            'value': 'New Life Line Rehabilitation Center',
            'iconSvg': 'assets/icons/Center_Name.svg',
          },
          {
            'label': 'Preferred Mentor',
            'value': 'Abhijit Patel',
            'iconSvg': 'assets/icons/Mentor.svg',
          },
          {
            'label': 'Phone Number (Rehab)',
            'value': '+91 xxxx-xxxxxx',
            'iconSvg': 'assets/icons/Profile_number.svg',
          },
          {
            'label': 'Medical History',
            'value': 'No',
            'iconSvg': 'assets/icons/Medical_History.svg',
          },
          {
            'label': 'Rehab Center Address',
            'value': 'Daryaganj, Delhi, 110002, India',
            'iconSvg': 'assets/icons/Profile_location.svg',
          },
        ],
      },
      {
        'title': 'Password',
        'items': [
          {
            'label': 'Current Password',
            'value': '••••••••',
            'iconSvg': 'assets/icons/Password.svg',
          },
        ],
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.lightBlueTransparent,
      body: CustomScrollView(
        slivers: [
          // SliverAppBar to create the fixed profile card
          SliverAppBar(
            expandedHeight: 300,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  // Background image
                  Positioned(
                    top: 0, // Set top position if necessary
                    left: 0,
                    right: 0,
                    height: 200, // Set a specific height for the image
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/Profile_bg_img.png'),
                          fit: BoxFit.cover, // Image will fill the container
                        ),
                      ),
                    ),
                  ),
                  // Positioned profile card content
                  Positioned(
                    top: 130,
                    left: 20,
                    right: 20,
                    child: Material(
                      elevation: 8,
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // Card content
                          Container(
                            padding: const EdgeInsets.only(
                              top: 56,
                              bottom: 16,
                              left: 20,
                              right: 20,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF5B86E5), Color(0xFF36D1DC)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Text(
                                        'Sumanyu Singh Rathore',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Age: 28',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.edit, color: Colors.white),
                              ],
                            ),
                          ),

                          // Positioned avatar (half above card)
                          Positioned(
                            top: -40, // Half the avatar height
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 4,
                                  ),
                                ),
                                child: const CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage(
                                    'assets/images/profile.jpg',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Content section (scrollable)
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              var section = sections[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomAccordion(
                  title: section['title'] as String,
                  items: section['items'] as List<Map<String, String>>,
                  onEdit: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Edit ${section['title']}')),
                    );
                  },
                ),
              );
            }, childCount: sections.length),
          ),
        ],
      ),
    );
  }
}
