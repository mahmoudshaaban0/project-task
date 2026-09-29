import 'package:app_template/theme/theme_ext.dart';
import 'package:flutter/material.dart';

/// Atom: small uppercase caption above a section ("THIS MONTH", "RECENT").
class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      child: Text(
        text.toUpperCase(),
        style: context.typography.medium12.copyWith(
          color: context.colors.textTertiary,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
