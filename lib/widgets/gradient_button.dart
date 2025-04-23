import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GradientButton extends StatelessWidget {
  final String title;
  final double textSize;
  final VoidCallback onPressed;
  final Gradient gradient;
  final double borderRadius;
  final double height;
  final double width;
  final String? svgIconPath; // <-- Add this line
  final double iconSize; // <-- And this

  const GradientButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.gradient,
    this.textSize = 16,
    this.borderRadius = 12,
    this.height = 50,
    this.width = double.infinity,
    this.svgIconPath,
    this.iconSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: textSize,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (svgIconPath != null) ...[
                  const SizedBox(width: 8),
                  SvgPicture.asset(
                    svgIconPath!,
                    height: iconSize,
                    width: iconSize,
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
