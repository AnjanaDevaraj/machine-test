import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double minWidth;
  final double? height;
  final double textSize;
  final Color color;
  final Color? textColor;
  final String text;

  const CustomTextButton({
    Key? key,
    required this.onPressed,
    this.minWidth = 60,
    this.height,
    this.color = Colors.blue,
    this.textColor,
    required this.text,
    this.textSize = 14
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      minWidth: screenWidth-100,
      height: height ?? 40,
      color: color,
      child: Text(
        text,
        style: TextStyle(color: textColor ?? Colors.white,fontSize: textSize),
      ),
    );
  }
}