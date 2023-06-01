
import 'package:bein_ecommerce/core/utils/app_string/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_localization.dart';

class AppLocalizationsSetup {
  static const Iterable<Locale> supportedLocales = [
    Locale('ar'),
    Locale('en'),

  ];

  static const Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates =
  [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    DefaultCupertinoLocalizations.delegate
  ];

  static Locale? localeResolutionCallback(
      Locale? locale, Iterable<Locale>? supportedLocales) {
    for (Locale supportedLocale in supportedLocales!) {
      if (supportedLocale.languageCode == locale!.languageCode &&
          supportedLocale.countryCode == locale.countryCode) {
        return supportedLocale;
      }
    }
    return supportedLocales.first;
  }
}