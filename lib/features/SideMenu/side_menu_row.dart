import 'package:flutter/material.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';

class SideMenuRow extends StatelessWidget {
  final String title, image;
  final Color imageColor;
  final Function onPressed;

  SideMenuRow(
      {required this.title, required this.image, required this.onPressed, this.imageColor=const Color(0xFF001068)});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onPressed();
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Image.asset(
              'assets/images/$image',
              height: 25,
              color:
               Color(0xFF001068),
            ),
            SizedBox(
              width: 16.0,
            ),
            Text(
              local.translate(title),
              style: TextStyle(
                  color: kAccentColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
