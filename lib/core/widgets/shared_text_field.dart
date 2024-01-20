import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:queen_validators/queen_validators.dart';

class SharedTextFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextEditingController? textEditingController;

  SharedTextFormField(
      {Key? key,
      this.validator,
      this.onChanged,
      this.hintText,
      this.inputFormatters,
      this.keyboardType,
      this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType ?? TextInputType.text,
      controller: textEditingController ?? TextEditingController(),
      inputFormatters: inputFormatters,
      validator: validator ??
          qValidator([
            // if the textField contains value the rest of the validators
            // will run else it will pass alidation with checking them
            IsRequired(),
          ]),
      onChanged: onChanged ?? (value) {},
      decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(26.0),
              borderSide: BorderSide(color: Colors.grey)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(26.0),
              borderSide: BorderSide(color: Colors.grey)),
          hintText: hintText ?? "",
          hintStyle: TextStyle(color: Colors.black.withOpacity(.7))),
    );
  }
}
