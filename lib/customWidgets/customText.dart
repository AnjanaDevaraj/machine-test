import 'package:flutter/material.dart';


class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;
  final bool? softwrap;
  final FontWeight? weight;

  const CustomText({
    required this.text,
    this.color,
    this.size,
    this.weight,
    this.softwrap,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: softwrap ?? false,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: size ?? 14,
        fontWeight: weight ?? FontWeight.normal,
      ),
    );
  }
}
