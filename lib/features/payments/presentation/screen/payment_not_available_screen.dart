import 'package:app_template/common/widgets/base_scaffold.dart';
import 'package:app_template/theme/app_spacing.dart';
import 'package:app_template/theme/theme_ext.dart';
import 'package:flutter/material.dart';

/// Shown for `/payment/:id` when the id is unknown or still pending.
///
/// Deliberately says nothing about which case it is, so a guessed URL doesn't
/// confirm that a request exists.
class PaymentNotAvailableScreen extends StatelessWidget {
  const PaymentNotAvailableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(title: Text(context.localizations.paymentDetails)),
      body: Center(
        child: Padding(
          padding: const EdgeInsetsDirectional.all(AppSpacing.xxxxl),
          child: Text(
            context.localizations.paymentNotAvailable,
            textAlign: TextAlign.center,
            style: context.typography.regular16.copyWith(
              color: context.colors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
