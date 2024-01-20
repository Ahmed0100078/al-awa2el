import 'package:flutter/material.dart';

import '../../../core/constant.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPress;
  final String? text;

  CustomButton({this.onPress, this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 90.0),
      child: ElevatedButton(
        onPressed: onPress,
         style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              OutlinedBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(80.0))),
                                      padding: MaterialStateProperty.all<
                                              EdgeInsetsGeometry>(
                                          const EdgeInsets.all(0.0)),
                                      textStyle:
                                          MaterialStateProperty.all<TextStyle?>(
                                              TextStyle(color: Colors.white)),
                                    ),

        child: Container(
          width: double.infinity,
          decoration: kBoxDecoration.copyWith(
              borderRadius: BorderRadius.all(Radius.circular(87.0))),
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Center(
            child: Text(
              text!,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
