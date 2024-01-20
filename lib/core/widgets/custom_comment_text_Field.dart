import 'package:flutter/material.dart';

class CustomCommentTextField extends StatelessWidget {
  final Function (String)?onChanged;
  final Function (String)?onSubmitted;
  CustomCommentTextField(
      {Key ?key,  this.onChanged,  this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
          suffixIcon: Container(
            child: Icon(
              Icons.send,
              color: Colors.white,
            ),
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(60)),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.transparent,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.transparent,
              )),
          filled: true,
          fillColor: const Color(0xFFEEEEEE),
          hintText: 'تعليق'),
    );
  }
}
