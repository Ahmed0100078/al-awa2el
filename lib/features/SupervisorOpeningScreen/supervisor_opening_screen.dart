import 'package:flutter/material.dart';
import 'package:madaresco/features/Subjects/presentation/manager/subject_viewmodel.dart';
import 'package:madaresco/features/SuperVisorOpeningScreen/close_dialog.dart';
import 'package:madaresco/features/Supervisor/presentation/pages/father_page.dart';
import 'package:madaresco/main.dart';
import 'package:provider/provider.dart';
import '../../injection_container.dart';

class SuperVisorOpeningScreen extends StatefulWidget {
  @override
  _SuperVisorOpeningScreenState createState() =>
      _SuperVisorOpeningScreenState();
}

final GlobalKey<ScaffoldState> superScaffoldKey =
    new GlobalKey<ScaffoldState>();

class _SuperVisorOpeningScreenState extends State<SuperVisorOpeningScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final _items = ChangeNotifierProvider(
        create: (_) => sl<SubjectViewModel>(), child: FatherPage());
    return WillPopScope(
      onWillPop: () async {
        bool lastPage = await mainNavigatorKey.currentState!.maybePop();
        if (!lastPage) {
          bool result = await showCloseDialog(context);
          return result;
        } else {
          return false;
        }
      },
      child: Scaffold(
        key: superScaffoldKey,
        body: _items,
      ),
    );
  }

  Future<dynamic> showCloseDialog(BuildContext context) async {
    Dialog alertDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      child: CloseDialog(),
    );
    var close = await showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return ScaleTransition(scale: a1, child: alertDialog);
        },
        transitionDuration: Duration(milliseconds: 250),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return SizedBox();
        });
    return close;
  }
}
