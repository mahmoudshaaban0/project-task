import 'package:app_template/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// {@template app_button_theme}
/// Theme class which provides configuration of buttons.
///
/// - primary: the main action on a screen (e.g. Approve). Filled brand color.
/// - secondary: the alternative action (e.g. Reject). Outlined, neutral, so a
///   decline never competes visually with the main action.
/// {@endtemplate}
class AppButtonTheme extends ThemeExtension<AppButtonTheme> {
  /// {@macro app_button_theme}
  const AppButtonTheme({
    required this.primaryBackground,
    required this.primaryForeground,
    required this.primaryPressed,
    required this.secondaryBackground,
    required this.secondaryForeground,
    required this.secondaryBorder,
    required this.secondaryPressed,
    required this.disabledBackground,
    required this.disabledForeground,
    required this.focusRing,
  });

  /// {@macro app_button_theme}
  factory AppButtonTheme.fromColors(AppColors colors) {
    return AppButtonTheme(
      primaryBackground: colors.primary,
      primaryForeground: colors.onPrimary,
      primaryPressed: Color.alphaBlend(
        colors.onPrimary.withValues(alpha: 0.12),
        colors.primary,
      ),
      secondaryBackground: colors.surface,
      secondaryForeground: colors.textPrimary,
      secondaryBorder: colors.borderStrong,
      secondaryPressed: colors.surfaceContainer,
      disabledBackground: colors.surfaceContainerHigh,
      disabledForeground: colors.textDisabled,
      focusRing: colors.primary,
    );
  }

  /// {@macro app_button_theme}
  factory AppButtonTheme.light(AppColors colors) =>
      AppButtonTheme.fromColors(colors);

  /// {@macro app_button_theme}
  factory AppButtonTheme.dark(AppColors colors) =>
      AppButtonTheme.fromColors(colors);

  final Color primaryBackground;
  final Color primaryForeground;
  final Color primaryPressed;
  final Color secondaryBackground;
  final Color secondaryForeground;
  final Color secondaryBorder;
  final Color secondaryPressed;
  final Color disabledBackground;
  final Color disabledForeground;
  final Color focusRing;

  @override
  AppButtonTheme copyWith({
    Color? primaryBackground,
    Color? primaryForeground,
    Color? primaryPressed,
    Color? secondaryBackground,
    Color? secondaryForeground,
    Color? secondaryBorder,
    Color? secondaryPressed,
    Color? disabledBackground,
    Color? disabledForeground,
    Color? focusRing,
  }) {
    return AppButtonTheme(
      primaryBackground: primaryBackground ?? this.primaryBackground,
      primaryForeground: primaryForeground ?? this.primaryForeground,
      primaryPressed: primaryPressed ?? this.primaryPressed,
      secondaryBackground: secondaryBackground ?? this.secondaryBackground,
      secondaryForeground: secondaryForeground ?? this.secondaryForeground,
      secondaryBorder: secondaryBorder ?? this.secondaryBorder,
      secondaryPressed: secondaryPressed ?? this.secondaryPressed,
      disabledBackground: disabledBackground ?? this.disabledBackground,
      disabledForeground: disabledForeground ?? this.disabledForeground,
      focusRing: focusRing ?? this.focusRing,
    );
  }

  @override
  AppButtonTheme lerp(
    covariant ThemeExtension<AppButtonTheme>? other,
    double t,
  ) {
    if (other is! AppButtonTheme) return this;

    Color l(Color a, Color b) => Color.lerp(a, b, t)!;

    return AppButtonTheme(
      primaryBackground: l(primaryBackground, other.primaryBackground),
      primaryForeground: l(primaryForeground, other.primaryForeground),
      primaryPressed: l(primaryPressed, other.primaryPressed),
      secondaryBackground: l(secondaryBackground, other.secondaryBackground),
      secondaryForeground: l(secondaryForeground, other.secondaryForeground),
      secondaryBorder: l(secondaryBorder, other.secondaryBorder),
      secondaryPressed: l(secondaryPressed, other.secondaryPressed),
      disabledBackground: l(disabledBackground, other.disabledBackground),
      disabledForeground: l(disabledForeground, other.disabledForeground),
      focusRing: l(focusRing, other.focusRing),
    );
  }
}
