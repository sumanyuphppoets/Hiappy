import 'package:flutter/material.dart';

const double _buttonHeight = 48;
const double _buttonRadius = 30;

Widget buildOutlinedButton({
  required String text,
  Color? borderColor,
  Color? textColor,
  VoidCallback? onPressed,
}) {

  return IntrinsicWidth(
    child: SizedBox(
      height: _buttonHeight,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: borderColor!),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_buttonRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
      ),
    ),
  );
}

Widget buildGradientButton({
  required String text,
  List<Color>? gradientColors,
  VoidCallback? onPressed,
}) {
  final bool hasGradient = gradientColors != null && gradientColors.length >= 2;

  return IntrinsicWidth(
    child: SizedBox(
      height: _buttonHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: hasGradient
              ? LinearGradient(colors: gradientColors!)
              : null,
          color: hasGradient ? null : Colors.grey[300],
          borderRadius: BorderRadius.circular(_buttonRadius),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_buttonRadius),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24),
          ),
          child: Text(
            text,
            style: TextStyle(color: hasGradient ? Colors.white : Colors.black),
          ),
        ),
      ),
    ),
  );
}
