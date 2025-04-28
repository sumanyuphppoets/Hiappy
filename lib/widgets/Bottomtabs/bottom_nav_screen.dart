import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hiappy/core/constants/colors.dart';

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
  final Function(int) onTabSelected;

  const BottomNavBarScreen({
    super.key,
    required this.items,
    required this.onTabSelected,
  });

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final centerIndex = widget.items.length ~/ 2;
    final centerItem = widget.items[centerIndex];
    final isCenterActive = _currentIndex == centerIndex;

    return Scaffold(
      body: Stack(
        children: [
          widget.items[_currentIndex].screen,
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildCustomNavBar(centerIndex),
          ),
          // Floating center button
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = centerIndex;
                  });
                  widget.onTabSelected(centerIndex);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        isCenterActive
                            ? centerItem.activeSvgPath
                            : centerItem.inactiveSvgPath,
                        height: 70,
                        width: 70,
                      ),
                    ),
                    const SizedBox(height: 0),
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: isCenterActive
                            ? [AppColors.royalBlue, AppColors.skyBlue]
                            : [Colors.grey, Colors.grey],
                      ).createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      ),
                      child: const Text(
                        "Create a Session",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomNavBar(int centerIndex) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 65,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(widget.items.length, (index) {
          if (index == centerIndex) {
            return const SizedBox(width: 70); // Space for center button
          }
          final item = widget.items[index];
          final isActive = _currentIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _currentIndex = index;
              });
              widget.onTabSelected(index);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  height: isActive ? 3 : 0,
                  width: 70,
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.royalBlue : Colors.transparent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 6),
                SvgPicture.asset(
                  isActive ? item.activeSvgPath : item.inactiveSvgPath,
                  height: 20,
                  width: 20,
                ),
                const SizedBox(height: 4),
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: isActive
                        ? [AppColors.royalBlue, AppColors.skyBlue]
                        : [Colors.grey, Colors.grey],
                  ).createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
