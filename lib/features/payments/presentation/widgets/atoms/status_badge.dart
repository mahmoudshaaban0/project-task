import 'package:app_template/theme/app_spacing.dart';
import 'package:app_template/theme/theme_ext.dart';
import 'package:flutter/material.dart';

/// Atom: an "Approved" / "Rejected" pill.
///
/// Status is shown with an icon and a word as well as a color, so it still
/// reads for color-blind users and in grayscale.
class StatusBadge extends StatelessWidget {
  const StatusBadge({required this.approved, super.key});

  final bool approved;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final label = statusLabel(context, approved);
    final (icon, background, foreground) = approved
        ? (
            Icons.check_rounded,
            colors.successContainer,
            colors.onSuccessContainer,
          )
        : (
            Icons.close_rounded,
            colors.dangerContainer,
            colors.onDangerContainer,
          );

    return DecoratedBox(
      decoration: ShapeDecoration(
        color: background,
        shape: const StadiumBorder(),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xxs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12, color: foreground),
            const SizedBox(width: AppSpacing.xs),
            Text(
              label.toUpperCase(),
              style: context.typography.semiBold12.copyWith(
                color: foreground,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The localized status word shared by the badge and screen-reader labels.
String statusLabel(BuildContext context, bool approved) => approved
    ? context.localizations.statusApproved
    : context.localizations.statusRejected;
