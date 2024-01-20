import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';

void showThankYouDialog(BuildContext context) async {
  Dialog alertDialog = Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16.0)),
    ),
    child: ThankYouDialog(),
  );
  await showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return ScaleTransition(scale: a1, child: alertDialog);
      },
      transitionDuration: Duration(milliseconds: 250),
      barrierDismissible: false,
      barrierLabel: '',
      context: context,
      // ignore: missing_return
      pageBuilder: (context, animation1, animation2) {
        return SizedBox();
      });
}

class ThankYouDialog extends StatefulWidget {
  @override
  _ThankYouDialogState createState() => _ThankYouDialogState();
}

class _ThankYouDialogState extends State<ThankYouDialog> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2),(){
      Navigator.pop(context);
      Navigator.pop(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Lottie.asset('assets/lotti/success.json', repeat: false),
              SizedBox(
                height: 16,
              ),
              Text(
                local.translate('thanks'),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              SizedBox(
                height: 10.0,
              ),
            ]),
      ),
    );
  }
}
