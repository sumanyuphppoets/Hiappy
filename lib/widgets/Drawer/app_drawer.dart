import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerTile extends StatelessWidget {
  final IconData? icon;
  final String title;
  final VoidCallback onTap;
  final String? svgPath; // Optional SVG asset path

  const DrawerTile({
    this.icon,
    required this.title,
    required this.onTap,
    this.svgPath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.white24, width: 0.5)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            svgPath != null
                ? SvgPicture.asset(
                  svgPath!,
                  height: 24,
                  width: 24,
                  color: Colors.white,
                )
                : Icon(icon, color: Colors.white),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.white70,
            ),
          ],
        ),
      ),
    );
  }
}
