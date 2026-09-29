import 'package:app_template/theme/app_button_sizes.dart';
import 'package:app_template/theme/app_spacing.dart';
import 'package:app_template/theme/app_text_button_style.dart';
import 'package:app_template/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Builds the leading or trailing icon of an [AppTextButton], in the color the
/// button has resolved for its label.
typedef IconBuilder = Widget Function(Color iconColor);

/// Resolves the [AppTextButtonStyle] an [AppTextButton] should paint itself
/// with, once a [BuildContext] — and therefore the theme — is available.
typedef AppTextButtonStyleResolver =
    AppTextButtonStyle Function(BuildContext context);

/// {@template app_text_button}
/// A labelled button, optionally with a leading and/or trailing icon.
///
/// Its appearance comes from the [style] it is given rather than from
/// subclassing, so a variant can be chosen at runtime:
///
/// ```dart
/// AppTextButton(
///   label: 'Save',
///   style: isDestructive ? AppTextButtonStyle.danger : AppTextButtonStyle.primary,
/// )
/// ```
///
/// For the common variants, prefer the named constructors:
/// [AppTextButton.primary] and [AppTextButton.outline].
/// {@endtemplate}
class AppTextButton extends StatelessWidget {
  /// {@macro app_text_button}
  const AppTextButton({
    required this.label,
    required this.style,
    super.key,
    this.onTap,
    this.leading,
    this.trailing,
    this.appButtonSize = AppButtonSize.medium,
  });

  /// A button in the app's main call-to-action style.
  const AppTextButton.primary({
    required this.label,
    super.key,
    this.onTap,
    this.leading,
    this.trailing,
    this.appButtonSize = AppButtonSize.medium,
  }) : style = AppTextButtonStyle.primary;

  /// A button in the app's quieter, outlined style.
  const AppTextButton.outline({
    required this.label,
    super.key,
    this.onTap,
    this.leading,
    this.trailing,
    this.appButtonSize = AppButtonSize.medium,
  }) : style = AppTextButtonStyle.outline;

  /// The label for the text button.
  final String label;

  /// The colors and borders this button paints itself with.
  ///
  /// Use [AppTextButtonStyle.copyWith] to tweak a single color for one call
  /// site instead of declaring a new variant.
  final AppTextButtonStyleResolver style;

  /// The callback function for the text button.
  ///
  /// A null callback renders the button in its disabled colors.
  final VoidCallback? onTap;

  /// The leading icon for the text button.
  final IconBuilder? leading;

  /// The trailing icon for the text button.
  final IconBuilder? trailing;

  /// The size of the text button.
  final AppButtonSize appButtonSize;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = style(context);

    final betweenSpace = switch (appButtonSize) {
      AppButtonSize.small ||
      AppButtonSize.xSmall ||
      AppButtonSize.medium => AppSpacing.xs,
      AppButtonSize.large || AppButtonSize.xlarge => AppSpacing.sm,
      AppButtonSize.xxLarge => AppSpacing.lg,
    };

    final backgroundColor = WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return buttonStyle.disabled;
      }

      if (states.contains(WidgetState.hovered)) {
        return buttonStyle.hover;
      }

      if (states.contains(WidgetState.focused)) {
        return buttonStyle.focus;
      }

      return buttonStyle.background;
    });

    final inputTextColor = WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return buttonStyle.disabledText;
      }

      return buttonStyle.text;
    });

    final contentColor = onTap != null
        ? buttonStyle.text
        : buttonStyle.disabledText;

    return ElevatedButton(
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(0),
        splashFactory: NoSplash.splashFactory,
        overlayColor: backgroundColor,
        shape: WidgetStateProperty.resolveWith((states) {
          final shape = RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSpacing.xxl.r)),
          );

          if (states.contains(WidgetState.disabled)) {
            return shape.copyWith(side: buttonStyle.disabledBorder);
          }

          if (states.contains(WidgetState.focused)) {
            return shape.copyWith(side: buttonStyle.focusedBorder);
          }

          if (states.contains(WidgetState.hovered)) {
            return shape.copyWith(side: buttonStyle.hoverBorder);
          }

          if (states.contains(WidgetState.pressed)) {
            return shape.copyWith(side: buttonStyle.focusedBorder);
          }

          return shape.copyWith(side: buttonStyle.defaultBorder);
        }),
        backgroundColor: backgroundColor,
        foregroundColor: inputTextColor,
        fixedSize: WidgetStateProperty.all(switch (appButtonSize) {
          AppButtonSize.small ||
          AppButtonSize.xSmall => const Size(double.infinity, 36),
          AppButtonSize.medium => const Size(double.infinity, 40),
          AppButtonSize.large => const Size(double.infinity, 44),
          AppButtonSize.xlarge => const Size(double.infinity, 48),
          AppButtonSize.xxLarge => const Size(double.infinity, 56),
        }),
        padding: WidgetStateProperty.all(switch (appButtonSize) {
          AppButtonSize.small ||
          AppButtonSize.xSmall => const EdgeInsets.symmetric(horizontal: 12),
          AppButtonSize.medium => const EdgeInsets.symmetric(horizontal: 16),
          AppButtonSize.large => const EdgeInsets.symmetric(horizontal: 16),
          AppButtonSize.xlarge => const EdgeInsets.symmetric(horizontal: 20),
          AppButtonSize.xxLarge => const EdgeInsets.symmetric(horizontal: 38),
        }),
      ),
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[
            leading!(contentColor),
            SizedBox(width: betweenSpace),
          ],
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
            child: Text(
              label,
              style: (switch (appButtonSize) {
                AppButtonSize.small ||
                AppButtonSize.xSmall => context.typography.regular16,
                AppButtonSize.medium => context.typography.regular18,
                AppButtonSize.large => context.typography.regular22,
                AppButtonSize.xlarge => context.typography.bold28,
                AppButtonSize.xxLarge => context.typography.medium18,
              }).copyWith(color: contentColor),
            ),
          ),
          if (trailing != null) ...[
            SizedBox(width: betweenSpace),
            trailing!(contentColor),
          ],
        ],
      ),
    );
  }
}
