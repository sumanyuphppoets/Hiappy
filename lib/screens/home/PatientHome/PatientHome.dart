import 'package:flutter/material.dart';
import 'package:hiappy/screens/home/PatientHome/CreateSessionScreen/CreateSessionScreen.dart';
import 'package:hiappy/screens/home/PatientHome/MainHome.dart';
import 'package:hiappy/screens/home/PatientHome/MainSessionScreen.dart';
import 'package:hiappy/screens/home/PatientHome/ProfileSessionScreen/ProfileSessionScreen.dart';
import 'package:hiappy/screens/home/PatientHome/ZoneSessionScreen/ZoneSessionScreen.dart';
import 'package:hiappy/widgets/Bottomtabs/bottom_nav_screen.dart';
import 'package:hiappy/widgets/CustomAppbar/PatientCustomAppbar.dart';
import 'package:hiappy/widgets/Drawer/app_drawer.dart';

class PatientHome extends StatefulWidget {
  @override
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
          currentScreen is MainHome
              ? AppDrawer(
                name: 'Sumanyu Singh Rathore',
                email: 'sumanyusinghr@gmail.com',
                role: 'Patient',
                customTiles: [
                  ListTile(
                    leading: Icon(Icons.medical_services),
                    title: Text('Appointments'),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              )
              : null,
      body: SafeArea(
        child: BottomNavBarScreen(items: items, onTabSelected: _onTabSelected),
      ),
    );
  }
}
