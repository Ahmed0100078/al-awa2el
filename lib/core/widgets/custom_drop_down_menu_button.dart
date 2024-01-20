import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class CustomDropDownMenuButton<E> extends StatelessWidget {
  final String hintText;
  final List<E> items;
  final FormFieldValidator? validator;
  final DropdownSearchItemAsString? stringItems;
  final ValueChanged? onChanged;

  CustomDropDownMenuButton(
      {required this.items,
      required this.hintText,
      this.validator,
      this.stringItems,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DropdownSearch<E>(
        // dropdownDecoratorProps: DropDownDecoratorProps(
        //   dropdownSearchDecoration: const InputDecoration(
        //       contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        //       border: OutlineInputBorder()),
        // ),
        items: items,
        // label: hintText,
        itemAsString: stringItems != null
            ? stringItems
            : (E? data) {
                String d = json.encode(data);
                Map valueMap = json.decode(d);
                return valueMap['name'];
              }
        // => data.toString()
        ,
        // showSearchBox: false,
        // popupShape:
        //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
