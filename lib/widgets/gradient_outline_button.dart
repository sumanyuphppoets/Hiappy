import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GradientOutlineButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final List<Color> gradientColors;
  final String? svgAssetPath; // Optional icon
  final Color textColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double iconSize;
  final double fontSize;
  final double? width;

  const GradientOutlineButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.gradientColors,
    this.svgAssetPath,
    this.textColor = Colors.black,
    this.borderRadius = 30.0,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
    this.iconSize = 20.0,
    this.fontSize = 16.0,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradientColors),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      padding: const EdgeInsets.all(1), // 1px border
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Padding(
            padding: padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (svgAssetPath != null)
                
                  Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: SvgPicture.asset(
                      svgAssetPath!,
                      width: iconSize,
                      height: iconSize,
                    ),
                  ),
                  const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: fontSize,
                      color: textColor,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
