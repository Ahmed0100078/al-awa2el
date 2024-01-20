import 'package:flutter/material.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';

class MainRow extends StatelessWidget {
  const MainRow({
    Key? key,
    required this.local,
    required this.text,
    required this.image,
    this.notificationCount,
  }) : super(key: key);

  final AppLocalizations local;
  final String? text, image, notificationCount;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Center(
                child: Image.asset(
                  image!,
                  width: 40,
                  height: 40,
                  color: kAccentColor,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                local.translate(text!),
                textAlign: TextAlign.center,
                style: TextStyle(color: kAccentColor),
              )
            ],
          ),
        ),
        Positioned(
          top: 0.0,
          right: 5.0,
          child: Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Color(0xFF001068)),
            padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 5.0),
            child: Text(
              notificationCount ?? '0',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ]),
    );
  }
}
