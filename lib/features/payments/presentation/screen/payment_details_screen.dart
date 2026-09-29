import 'package:app_template/common/formatters/date_formatter.dart';
import 'package:app_template/common/formatters/money_formatter.dart';
import 'package:app_template/common/widgets/base_scaffold.dart';
import 'package:app_template/features/payments/data/models/payment_response_model.dart';
import 'package:app_template/features/payments/presentation/widgets/atoms/money_text.dart';
import 'package:app_template/features/payments/presentation/widgets/atoms/status_badge.dart';
import 'package:app_template/theme/app_spacing.dart';
import 'package:app_template/theme/theme_ext.dart';
import 'package:flutter/material.dart';

class PaymentDetailsScreen extends StatelessWidget {
  const PaymentDetailsScreen({required this.payment, super.key});

  final PaymentResponseModel payment;

  @override
  Widget build(BuildContext context) {
    final strings = context.localizations;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final amount = MoneyFormatter.format(
      amountInFils: payment.amountInFils,
      currency: payment.currency,
      locale: locale,
    );
    return BaseScaffold(
      appBar: AppBar(title: Text(context.localizations.paymentDetails)),
      body: ListView(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.xxl,
          AppSpacing.xxl,
          AppSpacing.xxl,
          96,
        ),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  payment.recipientName,
                  style: context.typography.semiBold18,
                ),
              ),
              StatusBadge(approved: payment.isApproved),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          MoneyText(amount, style: context.typography.bold28),
          const SizedBox(height: AppSpacing.xxl),
          const Divider(),
          _DetailRow(
            label: strings.date,
            // Match the decision date used by payment ordering and summaries.
            value: DateFormatter.formatDate(
              payment.decidedAt ?? payment.requestedAt,
              locale: locale,
            ),
          ),
          _DetailRow(label: strings.reference, value: payment.reference),
          _DetailRow(
            label: strings.note,
            value: payment.note ?? strings.noNote,
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.symmetric(vertical: AppSpacing.md),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: context.typography.regular14.copyWith(
              color: context.colors.textSecondary,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          flex: 2,
          child: SelectableText(value, style: context.typography.regular16),
        ),
      ],
    ),
  );
}
