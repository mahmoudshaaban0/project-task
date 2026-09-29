import 'package:app_template/features/payments/data/models/payment_response_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_payments_repository.dart';

void main() {
  group('PaymentsCubit', () {
    test('loads payments and approves an incoming request', () async {
      final requestedAt = DateTime(2026, 9, 20, 10);
      final cubit = await createLoadedPaymentsCubit(
        incomingRequests: [
          pendingPayment(
            id: 'new-payment',
            recipientName: 'Ahmed Khalid',
            amountInFils: 120000,
            reference: 'PAY-90001',
            requestedAt: requestedAt,
          ),
        ],
      );
      addTearDown(cubit.close);

      final request = await cubit.createRequest();

      expect(request!.status, PaymentStatus.pending);
      expect(cubit.state.decidedPayments, isEmpty);
      expect(cubit.state.decidedPaymentById(request.id), isNull);
      expect(await cubit.approve(request.id), isTrue);
      expect(cubit.state.decidedPayments.single.status, PaymentStatus.approved);
      expect(cubit.state.decidedPaymentById(request.id), isNotNull);
      expect(
        cubit.state.approvedTotalInFilsFor(
          DateTime.now(),
          currency: 'AED',
        ),
        120000,
      );
    });

    test(
      'keeps rejected payments but excludes them from the summary',
      () async {
        final cubit = await createLoadedPaymentsCubit(
          incomingRequests: [
            pendingPayment(
              id: 'rejected-payment',
              recipientName: 'Sara Mohamed',
              amountInFils: 34000,
              reference: 'PAY-90002',
            ),
          ],
        );
        addTearDown(cubit.close);
        final request = await cubit.createRequest();

        expect(await cubit.reject(request!.id), isTrue);
        expect(
          cubit.state.decidedPayments.single.status,
          PaymentStatus.rejected,
        );
        expect(
          cubit.state.approvedTotalInFilsFor(
            DateTime.now(),
            currency: 'AED',
          ),
          0,
        );
      },
    );

    test('does not decide an unknown or already-decided payment', () async {
      final cubit = await createLoadedPaymentsCubit(
        incomingRequests: [
          pendingPayment(
            id: 'one-decision',
            recipientName: 'Leo Davis',
            amountInFils: 90000,
            reference: 'PAY-90003',
          ),
        ],
      );
      addTearDown(cubit.close);
      final request = await cubit.createRequest();

      expect(await cubit.approve('missing'), isFalse);
      expect(await cubit.approve(request!.id), isTrue);
      expect(await cubit.reject(request.id), isFalse);
      expect(
        cubit.state.paymentById(request.id)!.status,
        PaymentStatus.approved,
      );
    });

    test('discards only pending requests', () async {
      final cubit = await createLoadedPaymentsCubit(
        incomingRequests: [
          pendingPayment(
            id: 'pending-to-discard',
            recipientName: 'Pending payment',
            amountInFils: 10000,
            reference: 'PAY-90005',
          ),
          pendingPayment(
            id: 'approved-to-keep',
            recipientName: 'Approved payment',
            amountInFils: 20000,
            reference: 'PAY-90006',
          ),
        ],
      );
      addTearDown(cubit.close);

      final pending = await cubit.createRequest();
      expect(await cubit.discardPending(pending!.id), isTrue);
      expect(cubit.state.paymentById(pending.id), isNull);

      final approved = await cubit.createRequest();
      await cubit.approve(approved!.id);

      expect(await cubit.discardPending(approved.id), isFalse);
      expect(cubit.state.paymentById(approved.id), isNotNull);
      expect(await cubit.discardPending('missing'), isFalse);
    });
  });
}
