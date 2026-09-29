import 'package:app_template/common/widgets/atoms/section_label.dart';
import 'package:app_template/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Molecule: a small caption over a prominent value ("TOTAL" / "AED 1,540").
class StatBlock extends StatelessWidget {
  const StatBlock({
    required this.label,
    required this.value,
    this.alignment = CrossAxisAlignment.start,
    super.key,
  });

  final String label;
  final Widget value;
  final CrossAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Column(
        crossAxisAlignment: alignment,
        mainAxisSize: MainAxisSize.min,
        children: [
          SectionLabel(label),
          const SizedBox(height: AppSpacing.xs),
          value,
        ],
      ),
    );
  }
}
