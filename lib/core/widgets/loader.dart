import 'package:flutter/material.dart';
import '../../main.dart';
import 'custom_loading_indicator.dart';

class Loader {
  static start() {
    showDialog(
      context: mainNavigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CustomLoadingIndicator(),
      ),
    );
  }

  static stop() {
    Navigator.pop(mainNavigatorKey.currentContext!);
  }

  static Widget loadingWidget() {
    return Center(
      child: CustomLoadingIndicator(),
    );
  }
}
