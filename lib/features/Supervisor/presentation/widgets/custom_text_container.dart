import 'package:flutter/material.dart';

/// container for the father feature
class CustomTextContainer extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry padding;
  CustomTextContainer({required this.text, required this.padding});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        height: 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  const Color(0xFF001068),
                  const Color(0xFF001068),
                ])),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
