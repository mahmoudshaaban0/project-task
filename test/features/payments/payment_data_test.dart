import 'package:app_template/features/payments/data/datasources/payment_remote_datasource.dart';
import 'package:app_template/features/payments/data/models/payment_response_model.dart';
import 'package:app_template/features/payments/data/repositories/payments_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'loads both JSON fixtures and keeps decisions in session memory',
    () async {
      final dataSource = AssetPaymentDataSource(bundle: rootBundle);
      final repository = PaymentsRepositoryImpl(dataSource: dataSource);

      final payments = await repository.getPayments();
      expect(payments, hasLength(5));
      expect(payments.first.id, 'seed-1');

      final firstRequest = await repository.createRequest();
      expect(firstRequest.recipientName, 'Ahmed Khalid');
      expect(firstRequest.status, PaymentStatus.pending);

      final approved = await repository.approve(firstRequest.id);
      expect(approved!.status, PaymentStatus.approved);
      expect(await repository.discardPending(firstRequest.id), isFalse);

      final secondRequest = await repository.createRequest();
      expect(secondRequest.recipientName, 'Sara Mohamed');
      expect(await repository.discardPending(secondRequest.id), isTrue);

      final updatedPayments = await repository.getPayments();
      expect(
        updatedPayments
            .singleWhere((payment) => payment.id == firstRequest.id)
            .status,
        PaymentStatus.approved,
      );
      expect(
        updatedPayments.where((payment) => payment.id == secondRequest.id),
        isEmpty,
      );
    },
  );
}
