import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hint;

  final Function(String)? onChange;
  final String? hintError;
  final String? Function(String?)? validator;
  CustomTextFormField(
      {required this.hint,
      required this.onChange,
      required this.hintError,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      validator: validator != null
          ? validator
          : (value) {
              if (value!.isEmpty) {
                return hintError;
              }
              return null;
            },
      onChanged: onChange,
      decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(26.0),
              borderSide: BorderSide(color: Colors.grey)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(26.0),
              borderSide: BorderSide(color: Colors.grey)),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey)),
    );
  }
}
