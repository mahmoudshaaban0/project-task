import 'dart:async';

import 'package:app_template/common/formatters/masking.dart';
import 'package:app_template/common/formatters/money_formatter.dart';
import 'package:app_template/common/widgets/atoms/bottom_sheet_wrapper.dart';
import 'package:app_template/features/payments/data/models/payment_response_model.dart';
import 'package:app_template/features/payments/presentation/cubit/approval_cubit.dart';
import 'package:app_template/features/payments/presentation/cubit/approval_state.dart';
import 'package:app_template/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApprovalSheet extends StatelessWidget {
  const ApprovalSheet({required this.payment, super.key});

  final PaymentResponseModel payment;

  @override
  Widget build(BuildContext context) {
    final strings = context.localizations;
    final amount = MoneyFormatter.format(
      amountInFils: payment.amountInFils,
      currency: payment.currency,
      locale: Localizations.localeOf(context).toLanguageTag(),
    );

    return BlocBuilder<ApprovalCubit, ApprovalState>(
      builder: (context, state) => BottomSheetWrapper(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.shield_outlined, size: 36),
            const SizedBox(height: 16),
            Text(strings.approvePayment, style: context.typography.semiBold18),
            const SizedBox(height: 24),
            Text(strings.recipient),
            Text(
              state.isRevealed
                  ? payment.recipientName
                  : maskName(payment.recipientName),
              style: context.typography.semiBold18,
            ),
            const SizedBox(height: 16),
            Text(strings.amount),
            Text(
              state.isRevealed
                  ? amount
                  : maskAmount(currency: payment.currency),
              style: context.typography.bold28,
            ),
            const SizedBox(height: 16),
            Text('${strings.reference}: ${payment.reference}'),
            const SizedBox(height: 16),
            Text(
              state.isRevealed
                  ? strings.reviewBeforeApproval
                  : strings.authenticateToReveal,
            ),
            if (state.hasFailed) ...[
              const SizedBox(height: 12),
              Text(strings.approvalFailed),
            ],
            const SizedBox(height: 24),
            if (state.isBusy)
              const Center(child: CircularProgressIndicator())
            else ...[
              FilledButton(
                onPressed: state.isRevealed
                    ? () => Navigator.pop(context, PaymentStatus.approved)
                    : () => unawaited(
                        context.read<ApprovalCubit>().authenticate(
                          strings.authenticateToReveal,
                        ),
                      ),
                child: Text(
                  state.isRevealed ? strings.approve : strings.revealDetails,
                ),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () => Navigator.pop(
                  context,
                  PaymentStatus.rejected,
                ),
                child: Text(strings.reject),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
