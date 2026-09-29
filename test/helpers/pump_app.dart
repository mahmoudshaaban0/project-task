import 'package:app_template/l10n/app_localizations.dart';
import 'package:app_template/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

extension PumpApp on WidgetTester {
  /// Pumps [widget] with the app's theme extensions and localizations.
  Future<void> pumpApp(
    Widget widget, {
    Locale locale = const Locale('en'),
    GlobalKey<NavigatorState>? navigatorKey,
  }) {
    return pumpWidget(
      MaterialApp(
        navigatorKey: navigatorKey,
        theme: AppTheme.light().materialTheme,
        locale: locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: widget,
      ),
    );
  }
}
