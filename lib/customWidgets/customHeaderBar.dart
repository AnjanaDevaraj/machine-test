import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String text;
  final bool navigateToHome;
  final bool isTimeTable;
  final int? targetTabIndex; // Optional target tab index

  const CustomHeader({
    Key? key,
    required this.text,
    this.navigateToHome = false,
    this.isTimeTable = false,
    this.targetTabIndex, // Allow for optional tab index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child:
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            text,
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
