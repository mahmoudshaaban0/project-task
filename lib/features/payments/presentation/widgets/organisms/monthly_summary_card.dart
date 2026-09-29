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
    final colors = context.colors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.primary,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colors.shadow,
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            PositionedDirectional(
              top: -54,
              end: -34,
              child: _DecorativeCircle(
                size: 150,
                color: colors.onPrimary.withValues(alpha: 0.08),
              ),
            ),
            PositionedDirectional(
              bottom: -72,
              start: -46,
              child: _DecorativeCircle(
                size: 170,
                color: colors.onPrimary.withValues(alpha: 0.06),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.all(AppSpacing.xxxxl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: colors.onPrimary.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.all(
                            AppSpacing.lg,
                          ),
                          child: Icon(
                            Icons.account_balance_wallet_outlined,
                            size: 22,
                            color: colors.onPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xl),
                      Expanded(
                        child: Text(
                          context.localizations.thisMonth,
                          style: context.typography.medium14.copyWith(
                            color: colors.onPrimary.withValues(alpha: 0.82),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xxxxl),
                  Text(
                    context.localizations.total,
                    style: context.typography.regular14.copyWith(
                      color: colors.onPrimary.withValues(alpha: 0.72),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  MoneyText(
                    total,
                    style: context.typography.semiBold36.copyWith(
                      color: colors.onPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxxxl),
                  Divider(
                    height: 1,
                    color: colors.onPrimary.withValues(alpha: 0.18),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  Row(
                    children: [
                      Icon(
                        Icons.receipt_long_outlined,
                        size: 18,
                        color: colors.onPrimary.withValues(alpha: 0.76),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(
                          context.localizations.paymentsCount,
                          style: context.typography.regular14.copyWith(
                            color: colors.onPrimary.withValues(alpha: 0.76),
                          ),
                        ),
                      ),
                      Text(
                        '$count',
                        style: context.typography.semiBold18.copyWith(
                          color: colors.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DecorativeCircle extends StatelessWidget {
  const _DecorativeCircle({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: DecoratedBox(
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
