import 'dart:async';

import 'package:app_template/common/routing/app_routes.dart';
import 'package:app_template/common/widgets/base_scaffold.dart';
import 'package:app_template/features/payments/presentation/cubit/payments_cubit.dart';
import 'package:app_template/features/payments/presentation/cubit/payments_state.dart';
import 'package:app_template/features/payments/presentation/widgets/molecules/payment_tile.dart';
import 'package:app_template/theme/app_spacing.dart';
import 'package:app_template/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentsCubit, PaymentsState>(
      builder: (context, state) {
        final payments = state.decidedPayments;
        return BaseScaffold(
          appBar: AppBar(title: Text(context.localizations.payments)),
          body: ListView.separated(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.xxl,
              AppSpacing.xxl,
              AppSpacing.xxl,
              96,
            ),
            itemCount: payments.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final payment = payments[index];
              return PaymentTile(
                key: ValueKey(payment.id),
                payment: payment,
                onTap: () => unawaited(
                  context.pushNamed(
                    AppRoutes.paymentDetails.name,
                    pathParameters: {'id': payment.id},
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
