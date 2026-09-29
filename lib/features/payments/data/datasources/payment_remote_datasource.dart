import 'dart:convert';

import 'package:app_template/features/payments/data/models/incoming_request_model.dart';
import 'package:app_template/features/payments/data/models/payment_response_model.dart';
import 'package:flutter/services.dart';

abstract interface class PaymentsRemoteDataSource {
  Future<List<PaymentResponseModel>> fetchPayments();

  Future<PaymentResponseModel> createIncomingRequest();

  Future<PaymentResponseModel?> updatePayment(PaymentResponseModel payment);

  Future<bool> deletePendingPayment(String id);
}

final class AssetPaymentDataSource implements PaymentsRemoteDataSource {
  AssetPaymentDataSource({required this._bundle});

  static const _paymentsPath = 'assets/mock/payments.json';
  static const _requestsPath = 'assets/mock/incoming_payment_requests.json';

  final AssetBundle _bundle;
  List<PaymentResponseModel>? _payments;
  List<IncomingRequestModel>? _requests;
  var _requestIndex = 0;
  var _nextRequestNumber = 90001;

  @override
  Future<List<PaymentResponseModel>> fetchPayments() async {
    await _loadPayments();
    return List<PaymentResponseModel>.unmodifiable(_payments!);
  }

  @override
  Future<PaymentResponseModel> createIncomingRequest() async {
    await Future.wait([_loadPayments(), _loadRequests()]);
    final requests = _requests!;
    if (requests.isEmpty) {
      throw const FormatException('No incoming payment requests configured.');
    }

    final template = requests[_requestIndex % requests.length];
    _requestIndex++;
    final requestNumber = _nextRequestNumber++;
    final payment = PaymentResponseModel(
      id: 'request-$requestNumber',
      recipientName: template.recipientName,
      amountInFils: template.amountInFils,
      currency: template.currency,
      status: PaymentStatus.pending,
      requestedAt: DateTime.now(),
      decidedAt: null,
      reference: 'PAY-$requestNumber',
      note: template.note,
    );
    _payments!.insert(0, payment);
    return payment;
  }

  @override
  Future<PaymentResponseModel?> updatePayment(
    PaymentResponseModel payment,
  ) async {
    await _loadPayments();
    final index = _payments!.indexWhere((item) => item.id == payment.id);
    if (index == -1) return null;
    _payments![index] = payment;
    return payment;
  }

  @override
  Future<bool> deletePendingPayment(String id) async {
    await _loadPayments();
    final index = _payments!.indexWhere((payment) => payment.id == id);
    if (index == -1 || _payments![index].isAlreadyApprovedOrRejected) {
      return false;
    }
    _payments!.removeAt(index);
    return true;
  }

  Future<void> _loadPayments() async {
    if (_payments != null) return;
    final decoded = await _loadObject(_paymentsPath);
    final rawPayments = decoded['payments'];
    if (rawPayments is! List) {
      throw const FormatException('"payments" must be a JSON list.');
    }
    try {
      _payments = rawPayments
          .map(
            (item) => PaymentResponseModel.fromJson(
              (item as Map<Object?, Object?>).cast<String, dynamic>(),
            ),
          )
          .toList();
    } on Object catch (error) {
      throw FormatException('Invalid payment data: $error');
    }
  }

  Future<void> _loadRequests() async {
    if (_requests != null) return;
    final decoded = await _loadObject(_requestsPath);
    final rawRequests = decoded['requests'];
    if (rawRequests is! List) {
      throw const FormatException('"requests" must be a JSON list.');
    }
    try {
      _requests = rawRequests
          .map(
            (item) => IncomingRequestModel.fromJson(
              (item as Map<Object?, Object?>).cast<String, dynamic>(),
            ),
          )
          .toList();
    } on Object catch (error) {
      throw FormatException('Invalid incoming request data: $error');
    }
  }

  Future<Map<String, dynamic>> _loadObject(String path) async {
    final source = await _bundle.loadString(path);
    final decoded = jsonDecode(source);
    if (decoded is! Map<Object?, Object?>) {
      throw FormatException('$path must contain a JSON object.');
    }
    return decoded.cast<String, dynamic>();
  }
}
