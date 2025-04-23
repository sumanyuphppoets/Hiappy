import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final double paddingTop;
  final double paddingBottom;

  const TitleText({
    super.key,
    required this.text,
    this.fontSize = 20,
    this.fontWeight = FontWeight.w600,
    this.color = Colors.black,
    this.textAlign = TextAlign.center,
    this.maxLines,
    this.overflow = TextOverflow.visible,
    this.paddingTop = 0,
    this.paddingBottom = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop, bottom: paddingBottom),
      child: Text(
        text,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
      ),
    );
  }
}
