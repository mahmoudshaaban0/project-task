import 'package:app_template/common/formatters/money_formatter.dart';
import 'package:app_template/common/widgets/atoms/app_card.dart';
import 'package:app_template/features/payments/data/models/payment_response_model.dart';
import 'package:app_template/features/payments/presentation/widgets/atoms/money_text.dart';
import 'package:app_template/features/payments/presentation/widgets/atoms/status_badge.dart';
import 'package:app_template/theme/app_spacing.dart';
import 'package:app_template/theme/theme_ext.dart';
import 'package:flutter/material.dart';

/// Molecule: one decided payment in a list: who, how much, and its status.
///
class PaymentTile extends StatelessWidget {
  const PaymentTile({
    required this.payment,
    required this.onTap,
    super.key,
  });

  final PaymentResponseModel payment;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final amount = MoneyFormatter.format(
      amountInFils: payment.amountInFils,
      currency: payment.currency,
      locale: Localizations.localeOf(context).toLanguageTag(),
    );
    final semanticsLabel = context.localizations.paymentTileSemantics(
      payment.recipientName,
      amount,
      statusLabel(context, payment.isApproved),
    );

    // One announcement for the whole row instead of three separate ones.
    return Semantics(
      button: true,
      label: semanticsLabel,
      excludeSemantics: true,
      child: AppCard(
        onTap: onTap,
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.xxl,
          vertical: AppSpacing.xl,
        ),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: context.colors.primaryContainer,
                borderRadius: BorderRadius.circular(14),
              ),
              child: SizedBox.square(
                dimension: 44,
                child: Icon(
                  Icons.person_outline_rounded,
                  color: context.colors.onPrimaryContainer,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.xl),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    payment.recipientName,
                    style: context.typography.semiBold16.copyWith(
                      color: context.colors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  StatusBadge(approved: payment.isApproved),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.xl),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MoneyText(
                  amount,
                  style: context.typography.semiBold16.copyWith(
                    color: context.colors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                // chevron_right mirrors automatically in RTL.
                Icon(
                  Icons.chevron_right_rounded,
                  size: 20,
                  color: context.colors.textTertiary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
