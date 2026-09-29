import 'package:app_template/theme/app_button.dart';
import 'package:app_template/theme/app_colors.dart';
import 'package:app_template/theme/app_input.dart';
import 'package:app_template/theme/app_typography.dart';
import 'package:flutter/material.dart';

final class AppTheme {
  const AppTheme({
    required this.colors,
    required this.typography,
    required this.inputTheme,
    required this.buttonTheme,
  });

  factory AppTheme.dark() {
    const darkColors = AppColors.dark();
    return AppTheme(
      colors: darkColors,
      typography: AppTypography.dark(darkColors),
      inputTheme: AppInputTheme.dark(darkColors),
      buttonTheme: AppButtonTheme.dark(darkColors),
    );
  }

  factory AppTheme.light() {
    const lightColors = AppColors.light();
    return AppTheme(
      colors: lightColors,
      typography: AppTypography.light(lightColors),
      inputTheme: AppInputTheme.light(lightColors),
      buttonTheme: AppButtonTheme.light(lightColors),
    );
  }
  final AppColors colors;
  final AppTypography typography;
  final AppInputTheme inputTheme;
  final AppButtonTheme buttonTheme;

  /// Maps the tokens onto Material's [ColorScheme] so stock widgets
  /// (AppBar, NavigationBar, BottomSheet, FAB, dialogs) match the design
  /// instead of falling back to Material's default purple.
  ThemeData get materialTheme {
    final colorScheme = ColorScheme(
      brightness: colors.brightness,
      primary: colors.primary,
      onPrimary: colors.onPrimary,
      primaryContainer: colors.primaryContainer,
      onPrimaryContainer: colors.onPrimaryContainer,
      secondary: colors.primary,
      onSecondary: colors.onPrimary,
      secondaryContainer: colors.primaryContainer,
      onSecondaryContainer: colors.onPrimaryContainer,
      tertiary: colors.accent,
      onTertiary: colors.onAccent,
      error: colors.danger,
      onError: colors.onDanger,
      errorContainer: colors.dangerContainer,
      onErrorContainer: colors.onDangerContainer,
      surface: colors.surface,
      onSurface: colors.textPrimary,
      onSurfaceVariant: colors.textSecondary,
      surfaceContainerLowest: colors.surface,
      surfaceContainerLow: colors.background,
      surfaceContainer: colors.surfaceContainer,
      surfaceContainerHigh: colors.surfaceContainerHigh,
      surfaceContainerHighest: colors.surfaceContainerHigh,
      outline: colors.borderStrong,
      outlineVariant: colors.border,
      scrim: colors.scrim,
      shadow: colors.shadow,
    );

    return ThemeData(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colors.background,
      dividerColor: colors.divider,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: colors.surface,
        foregroundColor: colors.textPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        shape: Border(bottom: BorderSide(color: colors.divider)),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors.accent,
        foregroundColor: colors.onAccent,
        shape: const CircleBorder(),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.surface,
        modalBackgroundColor: colors.surface,
        modalBarrierColor: colors.scrim,
        surfaceTintColor: Colors.transparent,
        dragHandleColor: colors.borderStrong,
      ),
      extensions: [colors, typography, inputTheme, buttonTheme],
    );
  }
}
