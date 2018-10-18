import 'dart:async';

import 'package:flutter/widgets.dart';

class DemoLocalization {
  final String unicornTitle = "Unicorn";

  static DemoLocalization of(BuildContext context) {
    return Localizations.of<DemoLocalization>(context, DemoLocalization);
  }
}

class DemoDelegate extends LocalizationsDelegate<DemoLocalization> {
  @override
  bool isSupported(Locale locale) {
    return true;
  }

  @override
  Future<DemoLocalization> load(Locale locale) async {
    return DemoLocalization();
  }

  @override
  bool shouldReload(LocalizationsDelegate<DemoLocalization> old) {
    return false;
  }
}
