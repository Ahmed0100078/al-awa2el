import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// typedef AsyncCallback = Future<void> Function(BuildContext);

class AppLifeCycleHandler extends StatefulWidget {
  const AppLifeCycleHandler(
      {Key? key,
      required this.child,
      this.resumeCallBack,
      this.suspendingCallBack})
      : super(key: key);
  final Widget child;
  final AsyncCallback? resumeCallBack;
  final AsyncCallback? suspendingCallBack;

  @override
  State<AppLifeCycleHandler> createState() => _AppLifeCycleHandlerState();
}

class _AppLifeCycleHandlerState extends State<AppLifeCycleHandler>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        if (widget.resumeCallBack != null) {
          await widget.resumeCallBack!();
        }
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        if (widget.suspendingCallBack != null) {
          await widget.suspendingCallBack!();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
//
// class LifecycleEventHandler extends WidgetsBindingObserver {
//   final AsyncCallback? resumeCallBack;
//   final AsyncCallback? suspendingCallBack;
//
//   LifecycleEventHandler({
//     this.resumeCallBack,
//     this.suspendingCallBack,
//   });
//
//   @override
//   Future<Null> didChangeAppLifecycleState(AppLifecycleState state) async {
//     switch (state) {
//       case AppLifecycleState.resumed:
//         if (resumeCallBack != null) {
//           await resumeCallBack!();
//         }
//         break;
//       case AppLifecycleState.inactive:
//       case AppLifecycleState.paused:
//       case AppLifecycleState.detached:
//         if (suspendingCallBack != null) {
//           await suspendingCallBack!();
//         }
//         break;
//     }
//   }
// }
