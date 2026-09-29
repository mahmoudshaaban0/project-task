import 'package:app_template/common/storage/key_value_storage.dart';
import 'package:app_template/theme/app_theme.dart';
import 'package:app_template/theme/app_theme_scope.dart';
import 'package:flutter/material.dart';

const _kThemeMode = 'themeMode';

/// {@template theme_scope_widget}
/// A class which handles all theme processes
///
/// initialize() method should be used as app starter in order to use
/// [AppTheme] in the app

/// {@endtemplate}
class ThemeScopeWidget extends StatefulWidget {
  /// {@macro theme_scope_widget}
  const ThemeScopeWidget({
    required this.child,
    required this.keyValueStorage,
    super.key,
  });

  /// The child widget
  final Widget child;

  /// The shared preferences
  final KeyValueStorage keyValueStorage;

  /// Initialize the [ThemeScopeWidget] with the given [child] widget
  static Future<ThemeScopeWidget> initialize(
    Widget child,
    KeyValueStorage keyValueStorage,
  ) async {
    return ThemeScopeWidget(keyValueStorage: keyValueStorage, child: child);
  }

  /// In order to use methods of [ThemeScopeWidget] this function
  /// should be called first. Theme change process will handled by
  /// [ThemeScopeWidget] automatically.
  static ThemeScopeWidgetState? of(BuildContext context) {
    return context.findRootAncestorStateOfType<ThemeScopeWidgetState>();
  }

  @override
  State<ThemeScopeWidget> createState() => ThemeScopeWidgetState();
}

/// The state for [ThemeScopeWidget].
class ThemeScopeWidgetState extends State<ThemeScopeWidget> {
  ThemeMode? _themeMode;

  /// Change the theme mode
  Future<void> changeTo(ThemeMode themeMode) async {
    if (_themeMode == themeMode) return;

    try {
      final index = ThemeMode.values.indexOf(themeMode);
      await widget.keyValueStorage.setInt(_kThemeMode, index);

      setState(() {
        _themeMode = themeMode;
      });
    } on Exception catch (_) {}
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    try {
      final themeModeIndex = widget.keyValueStorage.getInt(_kThemeMode) ?? 0;
      final themeMode = ThemeMode.values[themeModeIndex];

      _themeMode = themeMode;
    } on Exception catch (_) {
      _themeMode = ThemeMode.system;
    }
  }

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.platformBrightnessOf(context);

    final appTheme = switch (_themeMode!) {
      ThemeMode.light => AppTheme.light(),
      ThemeMode.dark => AppTheme.dark(),
      ThemeMode.system =>
        brightness == Brightness.dark ? AppTheme.dark() : AppTheme.light(),
    };

    return AppThemeScope(
      themeMode: _themeMode!,
      theme: appTheme,
      child: widget.child,
    );
  }
}
