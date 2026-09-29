import 'package:app_template/theme/app_colors.dart';
import 'package:app_template/theme/app_theme_scope.dart';
import 'package:flutter/material.dart';

class AppInputTheme extends ThemeExtension<AppInputTheme> {
  const AppInputTheme({
    required this.defaultText,
    required this.focusedOnBrand,
    required this.focusedTextDefault,
    required this.errorTextDefault,
    required this.successTextDefault,
    required this.disabledText,
    required this.borderDefault,
    required this.borderHover,
    required this.borderFocused,
    required this.borderError,
    required this.borderSuccess,
    required this.borderDisabled,
    required this.defaultColor,
    required this.disabledColor,
    required this.inputPlaceHolder,
  });

  /// {@macro app_input_theme}
  factory AppInputTheme.fromColors(AppColors colors) {
    return AppInputTheme(
      defaultText: colors.textPrimary,
      focusedOnBrand: colors.primary,
      focusedTextDefault: colors.textPrimary,
      errorTextDefault: colors.danger,
      successTextDefault: colors.success,
      disabledText: colors.textDisabled,
      borderDefault: colors.border,
      borderHover: colors.borderStrong,
      borderFocused: colors.primary,
      borderError: colors.danger,
      borderSuccess: colors.success,
      borderDisabled: colors.divider,
      defaultColor: colors.surface,
      disabledColor: colors.surfaceContainer,
      inputPlaceHolder: colors.textTertiary,
    );
  }

  /// {@macro app_input_theme}
  factory AppInputTheme.light(AppColors colors) =>
      AppInputTheme.fromColors(colors);

  /// {@macro app_input_theme}
  factory AppInputTheme.dark(AppColors colors) =>
      AppInputTheme.fromColors(colors);

  /// Context-based factory that uses AppThemeScope
  factory AppInputTheme.fromContext(BuildContext context) =>
      AppInputTheme.fromColors(AppThemeScope.of(context)!.theme.colors);

  /// The default text color.
  final Color defaultText;

  /// The text color when focused on brand.
  final Color focusedOnBrand;

  /// The text color when focused.
  final Color focusedTextDefault;

  /// The text color when error.
  final Color errorTextDefault;

  /// The text color when success.
  final Color successTextDefault;

  /// The text color when disabled.
  final Color disabledText;

  /// The default border color.
  final Color borderDefault;

  /// The border color when hovered.
  final Color borderHover;

  /// The border color when focused.
  final Color borderFocused;

  /// The border color when error.
  final Color borderError;

  /// The border color when success.
  final Color borderSuccess;

  /// The border color when disabled.
  final Color borderDisabled;

  /// The default color.
  final Color defaultColor;

  /// The disabled color.
  final Color disabledColor;

  /// The input placeholder color.
  final Color inputPlaceHolder;

  @override
  ThemeExtension<AppInputTheme> copyWith({
    Color? defaultText,
    Color? focusedOnBrand,
    Color? focusedTextDefault,
    Color? errorTextDefault,
    Color? successTextDefault,
    Color? disabledText,
    Color? borderDefault,
    Color? borderHover,
    Color? borderFocused,
    Color? borderError,
    Color? borderSuccess,
    Color? borderDisabled,
    Color? defaultColor,
    Color? disabledColor,
    Color? inputPlaceHolder,
  }) {
    return AppInputTheme(
      defaultText: defaultText ?? this.defaultText,
      focusedOnBrand: focusedOnBrand ?? this.focusedOnBrand,
      focusedTextDefault: focusedTextDefault ?? this.focusedTextDefault,
      errorTextDefault: errorTextDefault ?? this.errorTextDefault,
      successTextDefault: successTextDefault ?? this.successTextDefault,
      disabledText: disabledText ?? this.disabledText,
      borderDefault: borderDefault ?? this.borderDefault,
      borderHover: borderHover ?? this.borderHover,
      borderFocused: borderFocused ?? this.borderFocused,
      borderError: borderError ?? this.borderError,
      borderSuccess: borderSuccess ?? this.borderSuccess,
      borderDisabled: borderDisabled ?? this.borderDisabled,
      defaultColor: defaultColor ?? this.defaultColor,
      disabledColor: disabledColor ?? this.disabledColor,
      inputPlaceHolder: inputPlaceHolder ?? this.inputPlaceHolder,
    );
  }

  @override
  ThemeExtension<AppInputTheme> lerp(
    covariant ThemeExtension<AppInputTheme>? other,
    double t,
  ) {
    if (other is! AppInputTheme) {
      return this;
    }

    return AppInputTheme(
      defaultText: Color.lerp(defaultText, other.defaultText, t)!,
      focusedOnBrand: Color.lerp(focusedOnBrand, other.focusedOnBrand, t)!,
      focusedTextDefault: Color.lerp(
        focusedTextDefault,
        other.focusedTextDefault,
        t,
      )!,
      errorTextDefault: Color.lerp(
        errorTextDefault,
        other.errorTextDefault,
        t,
      )!,
      successTextDefault: Color.lerp(
        successTextDefault,
        other.successTextDefault,
        t,
      )!,
      disabledText: Color.lerp(disabledText, other.disabledText, t)!,
      borderDefault: Color.lerp(borderDefault, other.borderDefault, t)!,
      borderHover: Color.lerp(borderHover, other.borderHover, t)!,
      borderFocused: Color.lerp(borderFocused, other.borderFocused, t)!,
      borderError: Color.lerp(borderError, other.borderError, t)!,
      borderSuccess: Color.lerp(borderSuccess, other.borderSuccess, t)!,
      borderDisabled: Color.lerp(borderDisabled, other.borderDisabled, t)!,
      defaultColor: Color.lerp(defaultColor, other.defaultColor, t)!,
      disabledColor: Color.lerp(disabledColor, other.disabledColor, t)!,
      inputPlaceHolder: Color.lerp(
        inputPlaceHolder,
        other.inputPlaceHolder,
        t,
      )!,
    );
  }
}
