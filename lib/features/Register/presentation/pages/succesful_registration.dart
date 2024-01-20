import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';

class SuccesfulRegistration extends StatelessWidget {
  final String _message;

  const SuccesfulRegistration({
    required String message,
  }) : _message = message;

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Material(
      child: Container(
        color: Colors.grey.shade50,
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Lottie.asset('assets/lotti/success.json', repeat: false),
          SizedBox(
            height: 16,
          ),
          Text(
            local.translate(_message),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.0,
          ),
        ]),
      ),
    );
  }
}
