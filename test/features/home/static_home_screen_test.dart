import 'package:app_template/features/home/presentation/screen/home_screen.dart';
import 'package:app_template/features/payments/presentation/cubit/payments_cubit.dart';
import 'package:app_template/features/payments/presentation/widgets/molecules/payment_tile.dart';
import 'package:app_template/features/payments/presentation/widgets/organisms/monthly_summary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_payments_repository.dart';
import '../../helpers/pump_app.dart';

void main() {
  testWidgets('shows the monthly summary and decided payment rows', (
    tester,
  ) async {
    final cubit = await createLoadedPaymentsCubit(
      initialPayments: seedPayments(),
    );
    addTearDown(cubit.close);
    await tester.pumpApp(_homeWith(cubit));

    expect(find.text('AED 1,540.00'), findsOneWidget);
    expect(find.text('Ahmed K.'), findsOneWidget);
    expect(find.text('Leo D.'), findsOneWidget);
    expect(find.byType(PaymentTile), findsNWidgets(5));
  });

  testWidgets('updates when a pending request is approved', (tester) async {
    final cubit = await createLoadedPaymentsCubit(
      incomingRequests: [
        pendingPayment(
          id: 'new-home-payment',
          recipientName: 'Ahmed Khalid',
          amountInFils: 120000,
          reference: 'PAY-90004',
        ),
      ],
    );
    addTearDown(cubit.close);
    await tester.pumpApp(_homeWith(cubit));

    expect(find.text('AED 0.00'), findsOneWidget);
    expect(find.byType(PaymentTile), findsNothing);

    final request = await cubit.createRequest();
    await cubit.approve(request!.id);
    await tester.pump();

    expect(
      find.descendant(
        of: find.byType(MonthlySummaryCard),
        matching: find.text('AED 1,200.00'),
      ),
      findsOneWidget,
    );
    expect(find.byType(PaymentTile), findsOneWidget);
  });

  testWidgets('keeps the same UI in right-to-left layout', (tester) async {
    final cubit = await createLoadedPaymentsCubit(
      initialPayments: seedPayments(),
    );
    addTearDown(cubit.close);
    await tester.pumpApp(_homeWith(cubit), locale: const Locale('ar'));

    expect(tester.takeException(), isNull);
    expect(
      Directionality.of(tester.element(find.byType(HomeScreen))),
      TextDirection.rtl,
    );
  });
}

Widget _homeWith(PaymentsCubit cubit) {
  return BlocProvider.value(value: cubit, child: const HomeScreen());
}
