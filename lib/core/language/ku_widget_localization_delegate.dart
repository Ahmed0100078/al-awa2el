import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart' as intl;

class _KuMaterialLocalizationsDelegate
    extends LocalizationsDelegate<WidgetsLocalizations> {
  const _KuMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'ku';

  @override
  Future<WidgetsLocalizations> load(Locale locale) async {
    const String localeName = "ku";
    await intl.initializeDateFormatting(localeName, null);
    return SynchronousFuture<WidgetsLocalizations>(
      KuWidgetLocalizations(),
    );
  }

  @override
  bool shouldReload(_KuMaterialLocalizationsDelegate old) => false;
}

class KuWidgetLocalizations extends WidgetsLocalizations {
  static const LocalizationsDelegate<WidgetsLocalizations> delegate =
      _KuMaterialLocalizationsDelegate();

  @override
  TextDirection get textDirection => TextDirection.rtl;

  @override
  // TODO: implement reorderItemDown
  String get reorderItemDown => throw UnimplementedError();

  @override
  // TODO: implement reorderItemLeft
  String get reorderItemLeft => throw UnimplementedError();

  @override
  // TODO: implement reorderItemRight
  String get reorderItemRight => throw UnimplementedError();

  @override
  // TODO: implement reorderItemToEnd
  String get reorderItemToEnd => throw UnimplementedError();

  @override
  // TODO: implement reorderItemToStart
  String get reorderItemToStart => throw UnimplementedError();

  @override
  // TODO: implement reorderItemUp
  String get reorderItemUp => throw UnimplementedError();
}
