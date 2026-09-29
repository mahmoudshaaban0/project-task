import 'package:flutter/material.dart';

/// Semantic color tokens for the app.
///
/// Widgets should only use these role-based names (e.g. [textSecondary],
/// [successContainer]) and never raw hex values, so both themes stay
/// consistent and contrast is guaranteed in one place.
///
/// Contrast targets (WCAG 2.1 AA):
/// - text tokens on [surface] / [background]: >= 4.5:1
/// - `on*Container` tokens on their container: >= 4.5:1
/// - [border], [divider]: decorative, no contrast requirement
///
/// Status colors are generic (success / danger / warning / info). Map domain
/// states to them at the widget level, e.g. approved -> success,
/// rejected -> danger, pending -> warning. Never rely on color alone:
/// always pair it with a text label or icon.
final class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.brightness,
    required this.background,
    required this.surface,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textDisabled,
    required this.border,
    required this.borderStrong,
    required this.divider,
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.accent,
    required this.onAccent,
    required this.success,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.danger,
    required this.onDanger,
    required this.dangerContainer,
    required this.onDangerContainer,
    required this.warning,
    required this.warningContainer,
    required this.onWarningContainer,
    required this.info,
    required this.infoContainer,
    required this.onInfoContainer,
    required this.scrim,
    required this.shadow,
  });

  /// Light palette: white surfaces, black text, indigo brand, teal accent.
  ///
  /// Brand swatches: #FFFFFF, #000000, #94A3B8, #4051B5, #2DD4BF, #EF4444,
  /// #22C55E. Swatches that fail AA as text on white are used only where
  /// contrast isn't carried by them:
  /// - #94A3B8 (2.6:1) -> borders and disabled content.
  /// - #2DD4BF (1.9:1) -> [accent] fill, with black [onAccent] (11.3:1).
  /// - #22C55E / #EF4444 -> [success] / [danger] strokes and icons; status
  ///   text uses the dark `on*Container` shades (8:1+). White text on
  ///   [danger] is 3.8:1, so filled destructive buttons need large text.
  const AppColors.light()
    : this(
        brightness: Brightness.light,
        background: const Color(0xFFFFFFFF),
        surface: const Color(0xFFFFFFFF),
        surfaceContainer: const Color(0xFFF1F5F9),
        surfaceContainerHigh: const Color(0xFFE2E8F0),
        textPrimary: const Color(0xFF000000),
        textSecondary: const Color(0xFF475569), // 7.6:1
        textTertiary: const Color(0xFF64748B), // 4.8:1
        textDisabled: const Color(0xFF94A3B8),
        border: const Color(0xFF94A3B8),
        borderStrong: const Color(0xFF64748B),
        divider: const Color(0xFFE2E8F0),
        primary: const Color(0xFF4051B5), // white on it: 6.9:1
        onPrimary: const Color(0xFFFFFFFF),
        primaryContainer: const Color(0xFFE8EAF6),
        onPrimaryContainer: const Color(0xFF2A3580), // 9.1:1
        accent: const Color(0xFF2DD4BF),
        onAccent: const Color(0xFF000000),
        success: const Color(0xFF22C55E),
        successContainer: const Color(0xFFDCFCE7),
        onSuccessContainer: const Color(0xFF14532D), // 8.3:1
        danger: const Color(0xFFEF4444),
        onDanger: const Color(0xFFFFFFFF),
        dangerContainer: const Color(0xFFFEE2E2),
        onDangerContainer: const Color(0xFF7F1D1D), // 8.2:1
        warning: const Color(0xFFB45309),
        warningContainer: const Color(0xFFFEF3C7),
        onWarningContainer: const Color(0xFF78350F),
        info: const Color(0xFF0369A1),
        infoContainer: const Color(0xFFE0F2FE),
        onInfoContainer: const Color(0xFF0C4A6E),
        scrim: const Color(0x990B1220), // 60%
        shadow: const Color(0x1A0F172A), // 10%
      );

  /// Dark palette: deep navy surfaces (not pure black, to avoid smearing on
  /// OLED and keep elevation visible) with desaturated, lighter accents.
  const AppColors.dark()
    : this(
        brightness: Brightness.dark,
        background: const Color(0xFF0B1220),
        surface: const Color(0xFF111A2B),
        surfaceContainer: const Color(0xFF17223A),
        surfaceContainerHigh: const Color(0xFF1E2B47),
        textPrimary: const Color(0xFFE6EBF5),
        textSecondary: const Color(0xFFA3AEC2),
        textTertiary: const Color(0xFF7C889E),
        textDisabled: const Color(0xFF4A5670),
        border: const Color(0xFF26334D),
        borderStrong: const Color(0xFF3D4C6B),
        divider: const Color(0xFF1C2740),
        primary: const Color(0xFF8FA8FF),
        onPrimary: const Color(0xFF0B1640),
        primaryContainer: const Color(0xFF1C2D6B),
        onPrimaryContainer: const Color(0xFFDCE4FF),
        accent: const Color(0xFF2DD4BF),
        onAccent: const Color(0xFF042F2E),
        success: const Color(0xFF4ADE80),
        successContainer: const Color(0xFF0F2E1D),
        onSuccessContainer: const Color(0xFFBBF7D0),
        danger: const Color(0xFFF87171),
        onDanger: const Color(0xFF2A0A0C),
        dangerContainer: const Color(0xFF3B1215),
        onDangerContainer: const Color(0xFFFECACA),
        warning: const Color(0xFFFBBF24),
        warningContainer: const Color(0xFF3A2A0A),
        onWarningContainer: const Color(0xFFFDE68A),
        info: const Color(0xFF7DD3FC),
        infoContainer: const Color(0xFF0C2A3D),
        onInfoContainer: const Color(0xFFBAE6FD),
        scrim: const Color(0xB3000000), // 70%
        shadow: const Color(0x66000000), // 40%
      );

  final Brightness brightness;

  // ===== Surfaces =====
  /// Screen background (behind cards and lists).
  final Color background;

  /// Cards, sheets, dialogs, app bars.
  final Color surface;

  /// Filled areas inside a surface (summary card, input fill, selected row).
  final Color surfaceContainer;

  /// Stronger fill (pressed row, skeleton loaders, masked-value chips).
  final Color surfaceContainerHigh;

  // ===== Text & icons =====
  /// Headings, amounts, primary content.
  final Color textPrimary;

  /// Supporting text: labels, dates, metadata.
  final Color textSecondary;

  /// Least important readable text: captions, hints, placeholders.
  final Color textTertiary;

  /// Disabled content. Exempt from contrast rules, never use for info.
  final Color textDisabled;

  // ===== Lines =====
  /// Default borders for cards and inputs.
  final Color border;

  /// Emphasized borders (hover / outlined buttons).
  final Color borderStrong;

  /// Hairline separators between list items.
  final Color divider;

  // ===== Brand =====
  /// Main actions (Approve, selected tab, links, focus ring).
  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;

  /// Secondary highlight (the debug FAB). Fill only; put [onAccent] on it.
  final Color accent;
  final Color onAccent;

  // ===== Status =====
  final Color success;
  final Color successContainer;
  final Color onSuccessContainer;

  final Color danger;
  final Color onDanger;
  final Color dangerContainer;
  final Color onDangerContainer;

  final Color warning;
  final Color warningContainer;
  final Color onWarningContainer;

  final Color info;
  final Color infoContainer;
  final Color onInfoContainer;

  // ===== Overlays =====
  /// Barrier behind modal bottom sheets and dialogs.
  final Color scrim;
  final Color shadow;

  bool get isDark => brightness == Brightness.dark;

  @override
  AppColors copyWith({
    Brightness? brightness,
    Color? background,
    Color? surface,
    Color? surfaceContainer,
    Color? surfaceContainerHigh,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textDisabled,
    Color? border,
    Color? borderStrong,
    Color? divider,
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? accent,
    Color? onAccent,
    Color? success,
    Color? successContainer,
    Color? onSuccessContainer,
    Color? danger,
    Color? onDanger,
    Color? dangerContainer,
    Color? onDangerContainer,
    Color? warning,
    Color? warningContainer,
    Color? onWarningContainer,
    Color? info,
    Color? infoContainer,
    Color? onInfoContainer,
    Color? scrim,
    Color? shadow,
  }) {
    return AppColors(
      brightness: brightness ?? this.brightness,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceContainer: surfaceContainer ?? this.surfaceContainer,
      surfaceContainerHigh: surfaceContainerHigh ?? this.surfaceContainerHigh,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      textDisabled: textDisabled ?? this.textDisabled,
      border: border ?? this.border,
      borderStrong: borderStrong ?? this.borderStrong,
      divider: divider ?? this.divider,
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
      accent: accent ?? this.accent,
      onAccent: onAccent ?? this.onAccent,
      success: success ?? this.success,
      successContainer: successContainer ?? this.successContainer,
      onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
      danger: danger ?? this.danger,
      onDanger: onDanger ?? this.onDanger,
      dangerContainer: dangerContainer ?? this.dangerContainer,
      onDangerContainer: onDangerContainer ?? this.onDangerContainer,
      warning: warning ?? this.warning,
      warningContainer: warningContainer ?? this.warningContainer,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
      info: info ?? this.info,
      infoContainer: infoContainer ?? this.infoContainer,
      onInfoContainer: onInfoContainer ?? this.onInfoContainer,
      scrim: scrim ?? this.scrim,
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  AppColors lerp(covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;

    Color l(Color a, Color b) => Color.lerp(a, b, t)!;

    return AppColors(
      brightness: t < 0.5 ? brightness : other.brightness,
      background: l(background, other.background),
      surface: l(surface, other.surface),
      surfaceContainer: l(surfaceContainer, other.surfaceContainer),
      surfaceContainerHigh: l(surfaceContainerHigh, other.surfaceContainerHigh),
      textPrimary: l(textPrimary, other.textPrimary),
      textSecondary: l(textSecondary, other.textSecondary),
      textTertiary: l(textTertiary, other.textTertiary),
      textDisabled: l(textDisabled, other.textDisabled),
      border: l(border, other.border),
      borderStrong: l(borderStrong, other.borderStrong),
      divider: l(divider, other.divider),
      primary: l(primary, other.primary),
      onPrimary: l(onPrimary, other.onPrimary),
      primaryContainer: l(primaryContainer, other.primaryContainer),
      onPrimaryContainer: l(onPrimaryContainer, other.onPrimaryContainer),
      accent: l(accent, other.accent),
      onAccent: l(onAccent, other.onAccent),
      success: l(success, other.success),
      successContainer: l(successContainer, other.successContainer),
      onSuccessContainer: l(onSuccessContainer, other.onSuccessContainer),
      danger: l(danger, other.danger),
      onDanger: l(onDanger, other.onDanger),
      dangerContainer: l(dangerContainer, other.dangerContainer),
      onDangerContainer: l(onDangerContainer, other.onDangerContainer),
      warning: l(warning, other.warning),
      warningContainer: l(warningContainer, other.warningContainer),
      onWarningContainer: l(onWarningContainer, other.onWarningContainer),
      info: l(info, other.info),
      infoContainer: l(infoContainer, other.infoContainer),
      onInfoContainer: l(onInfoContainer, other.onInfoContainer),
      scrim: l(scrim, other.scrim),
      shadow: l(shadow, other.shadow),
    );
  }
}
