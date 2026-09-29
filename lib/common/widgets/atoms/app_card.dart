import 'package:app_template/theme/app_spacing.dart';
import 'package:app_template/theme/theme_ext.dart';
import 'package:flutter/material.dart';

/// Atom: a bordered surface. Tappable (with ink feedback) when [onTap] is set.
class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    this.onTap,
    this.padding = const EdgeInsetsDirectional.all(AppSpacing.xxl),
    super.key,
  });

  static const radius = BorderRadius.all(Radius.circular(12));

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(color: context.colors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
