import 'package:flutter/material.dart';

const double _buttonHeight = 48;
const double _buttonRadius = 30;

Widget buildOutlinedButton({
  required String text,
  required Color color,
  VoidCallback? onPressed,
}) {
  return IntrinsicWidth(
    child: SizedBox(
      height: _buttonHeight,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_buttonRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24), // dynamic padding
        ),
        child: Text(text, style: TextStyle(color: color)),
      ),
    ),
  );
}

Widget buildGradientButton({
  required String text,
  VoidCallback? onPressed,
}) {
  return IntrinsicWidth(
    child: SizedBox(
      height: _buttonHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF56CCF2), Color(0xFF2F80ED)],
          ),
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
            padding: const EdgeInsets.symmetric(horizontal: 24), // dynamic padding
          ),
          child: Text(text, style: const TextStyle(color: Colors.white)),
        ),
      ),
    ),
  );
}
