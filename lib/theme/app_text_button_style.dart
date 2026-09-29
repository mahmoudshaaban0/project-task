import 'package:app_template/theme/app_text_button.dart';
import 'package:app_template/theme/theme_ext.dart';
import 'package:flutter/material.dart';

/// {@template app_text_button_style}
/// The colors and borders an [AppTextButton] paints itself with.
///
/// This is plain data — it holds no behaviour. Each visual variant of the
/// button (primary, outline, ...) is one of these values, not a subclass.
/// {@endtemplate}
@immutable
class AppTextButtonStyle {
  /// {@macro app_text_button_style}
  const AppTextButtonStyle({
    required this.background,
    required this.text,
    required this.focus,
    required this.hover,
    required this.disabled,
    required this.disabledText,
    this.defaultBorder = BorderSide.none,
    this.focusedBorder = BorderSide.none,
    this.hoverBorder = BorderSide.none,
    this.disabledBorder = BorderSide.none,
  });

  /// The filled, unpressed style of the app's main call to action.
  factory AppTextButtonStyle.primary(BuildContext context) {
    return AppTextButtonStyle(
      background: context.buttonTheme.primaryBackground,
      text: context.buttonTheme.primaryForeground,
      focus: context.buttonTheme.primaryPressed,
      hover: context.buttonTheme.primaryPressed,
      disabled: context.buttonTheme.disabledBackground,
      disabledText: context.buttonTheme.disabledForeground,
    );
  }

  /// The quieter, outlined style used for secondary actions.
  factory AppTextButtonStyle.outline(BuildContext context) {
    final border = BorderSide(color: context.buttonTheme.secondaryBorder);
    return AppTextButtonStyle(
      background: context.buttonTheme.secondaryBackground,
      text: context.buttonTheme.secondaryForeground,
      focus: context.buttonTheme.secondaryPressed,
      hover: context.buttonTheme.secondaryPressed,
      disabled: context.buttonTheme.disabledBackground,
      disabledText: context.buttonTheme.disabledForeground,
      defaultBorder: border,
      hoverBorder: border,
      focusedBorder: BorderSide(color: context.buttonTheme.focusRing, width: 2),
      disabledBorder: BorderSide(color: context.colors.border),
    );
  }

  /// The background color at rest, and while pressed.
  final Color background;

  /// The color of the label and of the leading/trailing icons.
  final Color text;

  /// The background color while the button holds focus.
  final Color focus;

  /// The background color while the pointer hovers the button.
  final Color hover;

  /// The background color while the button has no [AppTextButton.onTap].
  final Color disabled;

  /// The label color while the button has no [AppTextButton.onTap].
  final Color disabledText;

  /// The border at rest.
  final BorderSide defaultBorder;

  /// The border while the button holds focus, and while pressed.
  final BorderSide focusedBorder;

  /// The border while the pointer hovers the button.
  final BorderSide hoverBorder;

  /// The border while the button has no [AppTextButton.onTap].
  final BorderSide disabledBorder;

  /// Returns a copy of this style with the given fields replaced.
  ///
  /// Use this to tweak one color at a call site without declaring a whole new
  /// variant, e.g. a destructive action that is otherwise a primary button:
  ///
  /// ```dart
  /// AppTextButton(
  ///   label: 'Delete',
  ///   style: (context) => AppTextButtonStyle.primary(
  ///     context,
  ///   ).copyWith(
  ///     background: context.colors.danger,
  ///     text: context.colors.onDanger,
  ///   ),
  /// )
  /// ```
  AppTextButtonStyle copyWith({
    Color? background,
    Color? text,
    Color? focus,
    Color? hover,
    Color? disabled,
    Color? disabledText,
    BorderSide? defaultBorder,
    BorderSide? focusedBorder,
    BorderSide? hoverBorder,
    BorderSide? disabledBorder,
  }) {
    return AppTextButtonStyle(
      background: background ?? this.background,
      text: text ?? this.text,
      focus: focus ?? this.focus,
      hover: hover ?? this.hover,
      disabled: disabled ?? this.disabled,
      disabledText: disabledText ?? this.disabledText,
      defaultBorder: defaultBorder ?? this.defaultBorder,
      focusedBorder: focusedBorder ?? this.focusedBorder,
      hoverBorder: hoverBorder ?? this.hoverBorder,
      disabledBorder: disabledBorder ?? this.disabledBorder,
    );
  }
}
