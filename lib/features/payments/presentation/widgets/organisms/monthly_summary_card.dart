import 'package:app_template/common/widgets/atoms/app_card.dart';
import 'package:app_template/common/widgets/atoms/section_label.dart';
import 'package:app_template/common/widgets/molecules/stat_block.dart';
import 'package:app_template/features/payments/presentation/widgets/atoms/money_text.dart';
import 'package:app_template/theme/app_spacing.dart';
import 'package:app_template/theme/theme_ext.dart';
import 'package:flutter/material.dart';

/// Organism: "This month" caption plus a card with the total and the count of
/// approved payments.
class MonthlySummaryCard extends StatelessWidget {
  const MonthlySummaryCard({
    required this.total,
    required this.count,
    super.key,
  });

  final String total;
  final int count;

  @override
  Widget build(BuildContext context) {
    final valueStyle = context.typography.bold22.copyWith(
      color: context.colors.textPrimary,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionLabel(context.localizations.thisMonth),
        const SizedBox(height: AppSpacing.md),
        AppCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: StatBlock(
                  label: context.localizations.total,
                  value: MoneyText(total, style: valueStyle),
                ),
              ),
              const SizedBox(width: AppSpacing.xxl),
              StatBlock(
                label: context.localizations.paymentsCount,
                alignment: CrossAxisAlignment.end,
                value: Text('$count', style: valueStyle),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
