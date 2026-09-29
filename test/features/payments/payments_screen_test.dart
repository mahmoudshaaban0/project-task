import 'package:app_template/features/payments/data/models/payment_response_model.dart';
import 'package:app_template/features/payments/presentation/screen/payments_screen.dart';
import 'package:app_template/features/payments/presentation/widgets/molecules/payment_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_payments_repository.dart';
import '../../helpers/pump_app.dart';

void main() {
  testWidgets(
    'shows decided payments newest first and hides pending requests',
    (
      tester,
    ) async {
      final cubit = await createLoadedPaymentsCubit(
        initialPayments: [
          PaymentResponseModel(
            id: 'older',
            recipientName: 'Older payment',
            amountInFils: 10000,
            currency: 'AED',
            status: PaymentStatus.approved,
            requestedAt: DateTime(2026, 9),
            decidedAt: DateTime(2026, 9, 2),
            reference: 'PAY-OLDER',
          ),
          PaymentResponseModel(
            id: 'newer',
            recipientName: 'Newer payment',
            amountInFils: 20000,
            currency: 'AED',
            status: PaymentStatus.rejected,
            requestedAt: DateTime(2026, 9, 3),
            decidedAt: DateTime(2026, 9, 4),
            reference: 'PAY-NEWER',
          ),
          pendingPayment(
            id: 'pending',
            recipientName: 'Pending payment',
            amountInFils: 30000,
            reference: 'PAY-PENDING',
            requestedAt: DateTime(2026, 9, 5),
          ),
        ],
      );
      addTearDown(cubit.close);

      await tester.pumpApp(
        BlocProvider.value(value: cubit, child: const PaymentsScreen()),
      );

      final tiles = tester
          .widgetList<PaymentTile>(find.byType(PaymentTile))
          .toList();
      expect(tiles.map((tile) => tile.payment.id), ['newer', 'older']);
      expect(find.text('Pending payment'), findsNothing);
    },
  );
}
