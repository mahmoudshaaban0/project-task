import 'dart:async';

import 'package:app_template/common/constants/app_constants.dart';
import 'package:app_template/common/formatters/money_formatter.dart';
import 'package:app_template/common/routing/app_routes.dart';
import 'package:app_template/common/widgets/base_scaffold.dart';
import 'package:app_template/features/payments/presentation/cubit/payments_cubit.dart';
import 'package:app_template/features/payments/presentation/cubit/payments_state.dart';
import 'package:app_template/features/payments/presentation/widgets/organisms/monthly_summary_card.dart';
import 'package:app_template/features/payments/presentation/widgets/organisms/recent_payments_section.dart';
import 'package:app_template/theme/app_spacing.dart';
import 'package:app_template/theme/theme_ext.dart';
import 'package:app_template/theme/theme_mode_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentsCubit, PaymentsState>(
      builder: (context, state) {
        final now = DateTime.now();
        final total = MoneyFormatter.format(
          amountInFils: state.approvedTotalInFilsFor(
            now,
            currency: AppConstants.aedCurrency,
          ),
          currency: AppConstants.aedCurrency,
          locale: Localizations.localeOf(context).toLanguageTag(),
        );
        final count = state.approvedCountFor(
          now,
          currency: AppConstants.aedCurrency,
        );

        return BaseScaffold(
          appBar: AppBar(
            title: Text(context.localizations.home),
            actions: [
              IconButton(
                onPressed: () {
                  final themeScope = ThemeScopeWidget.of(context);
                  if (themeScope == null) return;

                  final nextMode = context.isDarkMode
                      ? ThemeMode.light
                      : ThemeMode.dark;
                  unawaited(themeScope.changeTo(nextMode));
                },
                icon: Icon(
                  context.isDarkMode
                      ? Icons.light_mode_outlined
                      : Icons.dark_mode_outlined,
                ),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.xxl,
              AppSpacing.xxl,
              AppSpacing.xxl,
              96,
            ),
            children: [
              MonthlySummaryCard(total: total, count: count),
              const SizedBox(height: AppSpacing.xxxxl),
              RecentPaymentsSection(
                payments: state.decidedPayments,
                onPaymentTap: (payment) {
                  unawaited(
                    context.pushNamed(
                      AppRoutes.paymentDetails.name,
                      pathParameters: {'id': payment.id},
                    ),
                  );
                },
                onSeeAll: () => context.goNamed(AppRoutes.payments.name),
              ),
            ],
          ),
        );
      },
    );
  }
}
