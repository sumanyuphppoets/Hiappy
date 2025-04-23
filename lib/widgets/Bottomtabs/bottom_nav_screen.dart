import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hiappy/core/constants/colors.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart' as pbn;

class BottomTabItem {
  final String title;
  final String activeSvgPath;
  final String inactiveSvgPath;
  final Widget screen;

  BottomTabItem({
    required this.title,
    required this.activeSvgPath,
    required this.inactiveSvgPath,
    required this.screen,
  });
}

class BottomNavBarScreen extends StatefulWidget {
  final List<BottomTabItem> items;
  final Function(int) onTabSelected;  // Add this parameter

  const BottomNavBarScreen({super.key, required this.items, required this.onTabSelected});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  late pbn.PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = pbn.PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return widget.items.map((item) => item.screen).toList();
  }

  List<pbn.PersistentBottomNavBarItem> _buildNavBarItems() {
    return widget.items.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      final bool isActive = _controller.index == index;
      final bool isCenterTab = index == (widget.items.length ~/ 2);

      return pbn.PersistentBottomNavBarItem(
        icon: isCenterTab
            ? const SizedBox.shrink() // We'll handle center icon separately
            : SvgPicture.asset(
                isActive ? item.activeSvgPath : item.inactiveSvgPath,
                height: 100,
                width: 100,
              ),
        title: isCenterTab ? "" : item.title,
        activeColorPrimary: AppColors.royalBlue,
        inactiveColorPrimary: Colors.grey,
        contentPadding: 0,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final centerIndex = widget.items.length ~/ 2;
    final centerItem = widget.items[centerIndex];
    final isActive = _controller.index == centerIndex;

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: pbn.PersistentTabView(
              context,
              controller: _controller,
              screens: _buildScreens(),
              items: _buildNavBarItems(),
              backgroundColor: AppColors.white,
              navBarStyle: pbn.NavBarStyle.style3,
              navBarHeight: 63,
              onItemSelected: (index) {
                widget.onTabSelected(index);  // Trigger the callback here
                setState(() {}); // 👈 this is crucial to update the icons
              },
              decoration: pbn.NavBarDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                colorBehindNavBar: AppColors.white,
              ),
            ),
          ),
          // Center button (floating above the navbar)
          Positioned(
            bottom: 12, // Adjust to control how much it floats above the nav bar
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  _controller.index = centerIndex;
                  widget.onTabSelected(centerIndex);
                  setState(() {});
                },
                child: SvgPicture.asset(
                  isActive ? centerItem.activeSvgPath : centerItem.inactiveSvgPath,
                  height: 110,
                  width: 110,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
