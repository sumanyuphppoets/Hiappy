import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiappy/features/auth/presentation/login.dart';
import 'package:hiappy/screens/home/PatientHome/About/About.dart';
import 'package:hiappy/screens/home/PatientHome/AccountSettings/AccountSettings.dart';
import 'package:hiappy/screens/home/PatientHome/CreateSessionScreen/CreateSessionScreen.dart';
import 'package:hiappy/screens/home/PatientHome/HelpandSupport/HelpandSupport.dart';
import 'package:hiappy/screens/home/PatientHome/MainHome.dart';
import 'package:hiappy/screens/home/PatientHome/MainSessionScreen.dart';
import 'package:hiappy/screens/home/PatientHome/PrivacyPolicy/PrivacyPolicy.dart';
import 'package:hiappy/screens/home/PatientHome/ProfileSessionScreen/ProfileSessionScreen.dart';
import 'package:hiappy/screens/home/PatientHome/Subscriptions/Subscriptions.dart'
    show Subscriptions;
import 'package:hiappy/screens/home/PatientHome/TermsofService/TermsofService.dart';
import 'package:hiappy/screens/home/PatientHome/ZoneSessionScreen/ZoneSessionScreen.dart';
import 'package:hiappy/widgets/Bottomtabs/bottom_nav_screen.dart';
import 'package:hiappy/widgets/CustomAppbar/PatientCustomAppbar.dart';
import 'package:hiappy/widgets/Drawer/app_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientHome extends StatefulWidget {
  const PatientHome({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PatientHomeState createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  int _selectedIndex = 0;

  // List of BottomTabItems
  List<BottomTabItem> items = [
    BottomTabItem(
      title: 'Home',
      inactiveSvgPath: 'assets/icons/HomeDeactivetab.svg',
      activeSvgPath: 'assets/icons/HomeActivetab.svg',
      screen: MainHome(),
    ),
    BottomTabItem(
      title: 'Sessions',
      inactiveSvgPath: 'assets/icons/SessionsDeactivetab.svg',
      activeSvgPath: 'assets/icons/SessionsActivetab.svg',
      screen: MainSessionScreen(),
    ),
    BottomTabItem(
      title: 'Create',
      inactiveSvgPath: 'assets/icons/Sessiontab.svg',
      activeSvgPath: 'assets/icons/Sessiontab.svg',
      screen: CreateSessionScreen(),
    ),
    BottomTabItem(
      title: 'Zone',
      inactiveSvgPath: 'assets/icons/MarkzoneDeactivetab.svg',
      activeSvgPath: 'assets/icons/MarkzoneActivetab.svg',
      screen: ZoneSessionScreen(),
    ),
    BottomTabItem(
      title: 'Profile',
      inactiveSvgPath: 'assets/icons/ProfileDeactivetab.svg',
      activeSvgPath: 'assets/icons/ProfileActivetab.svg',
      screen: ProfileSessionScreen(),
    ),
  ];

  // Method to update the selected screen index
  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentScreen = items[_selectedIndex].screen;

    return Scaffold(
      appBar: PatientCustomAppBar(
        centerImage: 'assets/images/StaySoberLogo.png',
        notificationIcon: 'assets/icons/Notificationicon.svg',
        sosIcon: 'assets/icons/SOSicon.svg',
        onBack: () => Navigator.of(context).maybePop(),
        isHomePage: currentScreen is MainHome,
      ),
      drawer:
          currentScreen is MainHome ||
                  currentScreen is CreateSessionScreen ||
                  currentScreen is ZoneSessionScreen ||
                  currentScreen is ProfileSessionScreen ||
                  currentScreen is MainSessionScreen
              ? SizedBox(
                width: double.infinity,
                child: Drawer(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF4D66E2), Color(0xFF3ABAEB)],
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                      ),
                    ),
                    child: SafeArea(
                      child: Column(
                        children: [
                          // Header with title and close button
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 12.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/Drawerlogo.svg',
                                  height: 60,
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          ),
                          const Divider(color: Colors.white30, thickness: 0.5),
                          const SizedBox(height: 10),
                          // Drawer tiles
                          Expanded(
                            child: ListView(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              children: [
                                DrawerTile(
                                  svgPath: 'assets/icons/Subscription.svg',
                                  title: 'Manage Subscription',
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Subscriptions(),
                                      ),
                                    );
                                  },
                                ),
                                DrawerTile(
                                  svgPath: 'assets/icons/Account.svg',
                                  title: 'Account Settings',
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => AccountSettings(),
                                      ),
                                    );
                                  },
                                ),
                                DrawerTile(
                                  svgPath: 'assets/icons/Language.svg',
                                  title: 'Change Language',
                                  onTap: () => Navigator.pop(context),
                                ),
                                DrawerTile(
                                  svgPath: 'assets/icons/Help.svg',
                                  title: 'Help & Support',
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => HelpandSupport(),
                                      ),
                                    );
                                  },
                                ),
                                DrawerTile(
                                  svgPath: 'assets/icons/Terms.svg',
                                  title: 'Terms of Services',
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => TermsofService(),
                                      ),
                                    );
                                  },
                                ),
                                DrawerTile(
                                  svgPath: 'assets/icons/About.svg',
                                  title: 'About',
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => About(),
                                      ),
                                    );
                                  },
                                ),
                                DrawerTile(
                                  svgPath: 'assets/icons/Privacy.svg',
                                  title: 'Privacy Policy',
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => PrivacyPolicy(),
                                      ),
                                    );
                                  },
                                ),
                                DrawerTile(
                                  svgPath: 'assets/icons/Logout.svg',
                                  title: 'Logout',
                                  onTap: () async {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs
                                        .clear(); // Clear all stored preferences

                                    // Optionally show a success message
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Logged out successfully',
                                        ),
                                      ),
                                    );

                                    // Navigate to the login screen or splash screen
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => LoginPage(),
                                      ), // replace with your actual login screen
                                      (route) => false,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 12.0),
                            child: Text(
                              'Update version 0.0.1',
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              : null,
      body: SafeArea(
        child: BottomNavBarScreen(items: items, onTabSelected: _onTabSelected),
      ),
    );
  }
}
