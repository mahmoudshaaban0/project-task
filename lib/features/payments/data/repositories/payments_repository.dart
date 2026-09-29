import 'package:app_template/features/payments/data/datasources/payment_remote_datasource.dart';
import 'package:app_template/features/payments/data/models/payment_response_model.dart';

abstract interface class PaymentsRepository {
  Future<List<PaymentResponseModel>> getPayments();

  Future<PaymentResponseModel> createRequest();

  Future<PaymentResponseModel?> approve(String id);

  Future<PaymentResponseModel?> reject(String id);

  Future<bool> discardPending(String id);
}

final class PaymentsRepositoryImpl implements PaymentsRepository {
  const PaymentsRepositoryImpl({required this._dataSource});

  final PaymentsRemoteDataSource _dataSource;

  @override
  Future<List<PaymentResponseModel>> getPayments() =>
      _dataSource.fetchPayments();

  @override
  Future<PaymentResponseModel> createRequest() =>
      _dataSource.createIncomingRequest();

  @override
  Future<PaymentResponseModel?> approve(String id) {
    return _decide(id, PaymentStatus.approved);
  }

  @override
  Future<PaymentResponseModel?> reject(String id) {
    return _decide(id, PaymentStatus.rejected);
  }

  @override
  Future<bool> discardPending(String id) {
    return _dataSource.deletePendingPayment(id);
  }

  Future<PaymentResponseModel?> _decide(String id, PaymentStatus status) async {
    final payments = await _dataSource.fetchPayments();
    PaymentResponseModel? pending;
    for (final payment in payments) {
      if (payment.id == id) {
        pending = payment;
        break;
      }
    }
    if (pending == null || pending.isAlreadyApprovedOrRejected) return null;

    final decided = PaymentResponseModel(
      id: pending.id,
      recipientName: pending.recipientName,
      amountInFils: pending.amountInFils,
      currency: pending.currency,
      status: status,
      requestedAt: pending.requestedAt,
      decidedAt: DateTime.now(),
      reference: pending.reference,
      note: pending.note,
    );
    return _dataSource.updatePayment(decided);
  }
}
