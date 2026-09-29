import 'package:app_template/features/payments/data/models/payment_response_model.dart';
import 'package:app_template/features/payments/data/repositories/payments_repository.dart';
import 'package:app_template/features/payments/presentation/cubit/payments_cubit.dart';

final class FakePaymentsRepository implements PaymentsRepository {
  FakePaymentsRepository({
    Iterable<PaymentResponseModel> initialPayments = const [],
    Iterable<PaymentResponseModel> incomingRequests = const [],
  }) : _payments = [...initialPayments],
       _incomingRequests = [...incomingRequests];

  final List<PaymentResponseModel> _payments;
  final List<PaymentResponseModel> _incomingRequests;

  @override
  Future<List<PaymentResponseModel>> getPayments() async =>
      List.unmodifiable(_payments);

  @override
  Future<PaymentResponseModel> createRequest() async {
    if (_incomingRequests.isEmpty) {
      throw StateError('No incoming request configured for this test.');
    }
    final request = _incomingRequests.removeAt(0);
    _payments.insert(0, request);
    return request;
  }

  @override
  Future<PaymentResponseModel?> approve(String id) =>
      _decide(id, PaymentStatus.approved);

  @override
  Future<PaymentResponseModel?> reject(String id) =>
      _decide(id, PaymentStatus.rejected);

  @override
  Future<bool> discardPending(String id) async {
    final index = _payments.indexWhere((payment) => payment.id == id);
    if (index == -1 || _payments[index].isAlreadyApprovedOrRejected) {
      return false;
    }
    _payments.removeAt(index);
    return true;
  }

  Future<PaymentResponseModel?> _decide(String id, PaymentStatus status) async {
    final index = _payments.indexWhere((payment) => payment.id == id);
    if (index == -1 || _payments[index].isAlreadyApprovedOrRejected) {
      return null;
    }
    final pending = _payments[index];
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
    _payments[index] = decided;
    return decided;
  }
}

Future<PaymentsCubit> createLoadedPaymentsCubit({
  Iterable<PaymentResponseModel> initialPayments = const [],
  Iterable<PaymentResponseModel> incomingRequests = const [],
}) async {
  final cubit = PaymentsCubit(
    repository: FakePaymentsRepository(
      initialPayments: initialPayments,
      incomingRequests: incomingRequests,
    ),
  );
  await cubit.loadPayments();
  return cubit;
}

PaymentResponseModel pendingPayment({
  required String id,
  required String recipientName,
  required int amountInFils,
  required String reference,
  DateTime? requestedAt,
}) {
  return PaymentResponseModel(
    id: id,
    recipientName: recipientName,
    amountInFils: amountInFils,
    currency: 'AED',
    status: PaymentStatus.pending,
    requestedAt: requestedAt ?? DateTime.now(),
    decidedAt: null,
    reference: reference,
  );
}

List<PaymentResponseModel> seedPayments() => [
  PaymentResponseModel(
    id: 'seed-1',
    recipientName: 'Ahmed K.',
    amountInFils: 120000,
    currency: 'AED',
    status: PaymentStatus.approved,
    requestedAt: DateTime(2026, 9, 10, 9, 25),
    decidedAt: DateTime(2026, 9, 10, 9, 30),
    reference: 'PAY-88213',
    note: 'Design retainer',
  ),
  PaymentResponseModel(
    id: 'seed-2',
    recipientName: 'Sara M.',
    amountInFils: 34000,
    currency: 'AED',
    status: PaymentStatus.approved,
    requestedAt: DateTime(2026, 9, 8, 12, 10),
    decidedAt: DateTime(2026, 9, 8, 12, 15),
    reference: 'PAY-88197',
    note: 'Team lunch',
  ),
  PaymentResponseModel(
    id: 'seed-3',
    recipientName: 'Leo D.',
    amountInFils: 90000,
    currency: 'AED',
    status: PaymentStatus.rejected,
    requestedAt: DateTime(2026, 9, 5, 15, 40),
    decidedAt: DateTime(2026, 9, 5, 15, 45),
    reference: 'PAY-88154',
    note: 'Duplicate invoice',
  ),
  PaymentResponseModel(
    id: 'seed-4',
    recipientName: 'Omar H.',
    amountInFils: 275000,
    currency: 'AED',
    status: PaymentStatus.approved,
    requestedAt: DateTime(2026, 8, 28, 10, 55),
    decidedAt: DateTime(2026, 8, 28, 11),
    reference: 'PAY-87902',
    note: 'Office rent share',
  ),
  PaymentResponseModel(
    id: 'seed-5',
    recipientName: 'Mona S.',
    amountInFils: 15000,
    currency: 'AED',
    status: PaymentStatus.rejected,
    requestedAt: DateTime(2026, 8, 19, 16, 15),
    decidedAt: DateTime(2026, 8, 19, 16, 20),
    reference: 'PAY-87811',
  ),
];
