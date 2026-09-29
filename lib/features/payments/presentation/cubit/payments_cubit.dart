import 'package:app_template/features/payments/data/models/payment_response_model.dart';
import 'package:app_template/features/payments/data/repositories/payments_repository.dart';
import 'package:app_template/features/payments/presentation/cubit/payments_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentsCubit extends Cubit<PaymentsState> {
  PaymentsCubit({required this.repository}) : super(PaymentsState.initial());

  final PaymentsRepository repository;

  Future<void> loadPayments() async {
    emit(PaymentsState(state.payments, status: PaymentsStatus.loading));
    try {
      final payments = await repository.getPayments();
      emit(PaymentsState(payments));
    } on Object catch (error) {
      _emitFailure(error);
    }
  }

  Future<PaymentResponseModel?> createRequest() async {
    try {
      final payment = await repository.createRequest();
      emit(PaymentsState([payment, ...state.payments]));
      return payment;
    } on Object catch (error) {
      _emitFailure(error);
      return null;
    }
  }

  Future<bool> approve(String id) async {
    try {
      final payment = await repository.approve(id);
      if (payment == null) return false;
      _replace(payment);
      return true;
    } on Object catch (error) {
      _emitFailure(error);
      return false;
    }
  }

  Future<bool> reject(String id) async {
    try {
      final payment = await repository.reject(id);
      if (payment == null) return false;
      _replace(payment);
      return true;
    } on Object catch (error) {
      _emitFailure(error);
      return false;
    }
  }

  Future<bool> discardPending(String id) async {
    try {
      final removed = await repository.discardPending(id);
      if (!removed) return false;
      emit(
        PaymentsState(
          state.payments.where((payment) => payment.id != id),
        ),
      );
      return true;
    } on Object catch (error) {
      _emitFailure(error);
      return false;
    }
  }

  void _replace(PaymentResponseModel payment) {
    final index = state.payments.indexWhere((item) => item.id == payment.id);
    if (index == -1) return;
    final updatedPayments = [...state.payments];
    updatedPayments[index] = payment;
    emit(PaymentsState(updatedPayments));
  }

  void _emitFailure(Object error) {
    emit(
      PaymentsState(
        state.payments,
        status: PaymentsStatus.failure,
        errorMessage: error.toString(),
      ),
    );
  }
}
