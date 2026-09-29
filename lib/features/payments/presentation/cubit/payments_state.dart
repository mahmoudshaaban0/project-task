import 'package:app_template/features/payments/data/models/payment_response_model.dart';
import 'package:equatable/equatable.dart';

enum PaymentsStatus { initial, loading, ready, failure }

final class PaymentsState extends Equatable {
  PaymentsState(
    Iterable<PaymentResponseModel> payments, {
    this.status = PaymentsStatus.ready,
    this.errorMessage,
  }) : payments = List<PaymentResponseModel>.unmodifiable(payments);

  factory PaymentsState.initial() {
    return PaymentsState(const [], status: PaymentsStatus.initial);
  }

  final List<PaymentResponseModel> payments;
  final PaymentsStatus status;
  final String? errorMessage;

  /// Excludes pending requests and places the newest decision first.
  List<PaymentResponseModel> get decidedPayments {
    final decided =
        payments
            .where((payment) => payment.isAlreadyApprovedOrRejected)
            .toList()
          ..sort((first, second) {
            return second.decidedAt!.compareTo(first.decidedAt!);
          });

    return List<PaymentResponseModel>.unmodifiable(decided);
  }

  PaymentResponseModel? paymentById(String id) {
    for (final payment in payments) {
      if (payment.id == id) return payment;
    }
    return null;
  }

  PaymentResponseModel? decidedPaymentById(String id) {
    final payment = paymentById(id);
    if (payment == null || !payment.isAlreadyApprovedOrRejected) return null;
    return payment;
  }

  int approvedCountFor(DateTime month, {required String currency}) {
    return _approvedPaymentsFor(month, currency: currency).length;
  }

  int approvedTotalInFilsFor(DateTime month, {required String currency}) {
    return _approvedPaymentsFor(month, currency: currency).fold(
      0,
      (total, payment) => total + payment.amountInFils,
    );
  }

  List<PaymentResponseModel> _approvedPaymentsFor(
    DateTime month, {
    required String currency,
  }) {
    return payments.where((payment) {
      final decidedAt = payment.decidedAt;
      return payment.isApproved &&
          payment.currency == currency &&
          decidedAt != null &&
          decidedAt.year == month.year &&
          decidedAt.month == month.month;
    }).toList();
  }

  @override
  List<Object?> get props => [payments, status, errorMessage];
}
