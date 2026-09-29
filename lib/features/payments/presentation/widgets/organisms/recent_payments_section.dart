import 'package:app_template/common/widgets/atoms/app_card.dart';
import 'package:app_template/common/widgets/atoms/section_label.dart';
import 'package:app_template/features/payments/data/models/payment_response_model.dart';
import 'package:app_template/features/payments/presentation/widgets/molecules/payment_tile.dart';
import 'package:app_template/theme/app_spacing.dart';
import 'package:app_template/theme/theme_ext.dart';
import 'package:flutter/material.dart';

/// Organism: "Recent" header with an optional "See all" action, then a tile
/// per payment, or a friendly empty state.
class RecentPaymentsSection extends StatelessWidget {
  const RecentPaymentsSection({
    required this.payments,
    required this.onPaymentTap,
    this.onSeeAll,
    super.key,
  });

  final List<PaymentResponseModel> payments;
  final ValueChanged<PaymentResponseModel> onPaymentTap;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: SectionLabel(context.localizations.recent)),
            if (payments.isNotEmpty) ...[
              DecoratedBox(
                decoration: ShapeDecoration(
                  color: context.colors.surfaceContainer,
                  shape: const StadiumBorder(),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.xs,
                  ),
                  child: Text(
                    '${payments.length}',
                    style: context.typography.semiBold12.copyWith(
                      color: context.colors.textSecondary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
            ],
            if (onSeeAll != null && payments.isNotEmpty)
              TextButton(
                onPressed: onSeeAll,
                child: Text(context.localizations.seeAll),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        if (payments.isEmpty)
          AppCard(
            child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                vertical: AppSpacing.xxxl,
              ),
              child: Column(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.colors.surfaceContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.all(AppSpacing.xxl),
                      child: Icon(
                        Icons.receipt_long_outlined,
                        color: context.colors.textTertiary,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  Text(
                    context.localizations.noRecentPayments,
                    textAlign: TextAlign.center,
                    style: context.typography.regular14.copyWith(
                      color: context.colors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          for (final (index, payment) in payments.indexed) ...[
            PaymentTile(
              key: ValueKey(payment.id),
              payment: payment,
              onTap: () => onPaymentTap(payment),
            ),
            if (index != payments.length - 1)
              const SizedBox(height: AppSpacing.md),
          ],
      ],
    );
  }
}
