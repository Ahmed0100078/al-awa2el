import 'package:flutter/material.dart';
import 'package:madaresco/core/language/AppLanguage.dart';
import 'package:provider/provider.dart';

class ChangeLanguageDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            if (appLanguage.appLocal != Locale("ar")) {
              appLanguage.changeLanguage(Locale("ar"));
            }
          },
          behavior: HitTestBehavior.translucent,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'العربية',
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Divider(
          height: 1,
          color: Colors.grey,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            if (appLanguage.appLocal != Locale("en")) {
              appLanguage.changeLanguage(Locale("en"));
            }
          },
          behavior: HitTestBehavior.translucent,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'English',
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Divider(
          height: 1,
          color: Colors.grey,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            if (appLanguage.appLocal != Locale("ku")) {
              appLanguage.changeLanguage(Locale("ku"));
            }
          },
          behavior: HitTestBehavior.translucent,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Kurdî',
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
