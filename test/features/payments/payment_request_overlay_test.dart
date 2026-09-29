import 'package:app_template/common/authentication/device_authenticator.dart';
import 'package:app_template/common/storage/key_value_storage.dart';
import 'package:app_template/common/widgets/base_scaffold.dart';
import 'package:app_template/features/payments/data/models/payment_response_model.dart';
import 'package:app_template/features/payments/presentation/cubit/payments_cubit.dart';
import 'package:app_template/features/payments/presentation/widgets/approval_sheet.dart';
import 'package:app_template/features/payments/presentation/widgets/payment_request_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_payments_repository.dart';
import '../../helpers/pump_app.dart';

void main() {
  testWidgets('FAB creates a request and approval updates the Cubit', (
    tester,
  ) async {
    final cubit = await _createCubit();
    addTearDown(cubit.close);
    final navigatorKey = GlobalKey<NavigatorState>();
    var approvalNavigationCount = 0;

    await tester.pumpApp(
      BlocProvider.value(
        value: cubit,
        child: PaymentRequestOverlay(
          navigatorKey: navigatorKey,
          storage: _MemoryStorage(),
          authenticator: _SuccessfulAuthenticator(),
          onApproved: () => approvalNavigationCount++,
          child: const BaseScaffold(body: SizedBox()),
        ),
      ),
      navigatorKey: navigatorKey,
    );

    await tester.tap(find.byKey(const ValueKey('payment-request-fab')));
    await tester.pumpAndSettle();

    final request = cubit.state.payments.single;
    expect(request.status, PaymentStatus.pending);
    expect(find.byType(ApprovalSheet), findsOneWidget);
    expect(find.text('A•••• K.'), findsOneWidget);
    expect(find.text('Reference: ${request.reference}'), findsOneWidget);
    expect(find.text(request.recipientName), findsNothing);

    await tester.tap(
      find.widgetWithText(FilledButton, 'Authenticate to reveal'),
    );
    await tester.pumpAndSettle();
    expect(find.text(request.recipientName), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Approve'));
    await tester.pumpAndSettle();

    expect(cubit.state.paymentById(request.id)!.status, PaymentStatus.approved);
    expect(approvalNavigationCount, 1);
  });

  testWidgets('rejection updates the Cubit without approval navigation', (
    tester,
  ) async {
    final cubit = await _createCubit();
    addTearDown(cubit.close);
    final navigatorKey = GlobalKey<NavigatorState>();
    var approvalNavigationCount = 0;

    await tester.pumpApp(
      BlocProvider.value(
        value: cubit,
        child: PaymentRequestOverlay(
          navigatorKey: navigatorKey,
          storage: _MemoryStorage(),
          authenticator: _SuccessfulAuthenticator(),
          onApproved: () => approvalNavigationCount++,
          child: const BaseScaffold(body: SizedBox()),
        ),
      ),
      navigatorKey: navigatorKey,
    );

    await tester.tap(find.byKey(const ValueKey('payment-request-fab')));
    await tester.pumpAndSettle();
    final request = cubit.state.payments.single;

    await tester.tap(find.widgetWithText(OutlinedButton, 'Reject'));
    await tester.pumpAndSettle();

    expect(cubit.state.paymentById(request.id)!.status, PaymentStatus.rejected);
    expect(approvalNavigationCount, 0);
  });

  testWidgets('closing the sheet discards its pending request', (tester) async {
    final cubit = await _createCubit();
    addTearDown(cubit.close);
    final navigatorKey = GlobalKey<NavigatorState>();

    await tester.pumpApp(
      BlocProvider.value(
        value: cubit,
        child: PaymentRequestOverlay(
          navigatorKey: navigatorKey,
          storage: _MemoryStorage(),
          authenticator: _SuccessfulAuthenticator(),
          onApproved: () {},
          child: const BaseScaffold(body: SizedBox()),
        ),
      ),
      navigatorKey: navigatorKey,
    );

    await tester.tap(find.byKey(const ValueKey('payment-request-fab')));
    await tester.pumpAndSettle();
    expect(cubit.state.payments.single.status, PaymentStatus.pending);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(cubit.state.payments, isEmpty);
  });
}

Future<PaymentsCubit> _createCubit() {
  return createLoadedPaymentsCubit(
    incomingRequests: [
      pendingPayment(
        id: 'request-90001',
        recipientName: 'Ahmed Khalid',
        amountInFils: 120000,
        reference: 'PAY-90001',
      ),
    ],
  );
}

final class _SuccessfulAuthenticator implements DeviceAuthenticator {
  @override
  Future<bool> authenticate(String reason) async => true;
}

final class _MemoryStorage implements KeyValueStorage {
  final _values = <String, Object>{};

  @override
  bool? getBool(String key) => _values[key] as bool?;

  @override
  double? getDouble(String key) => _values[key] as double?;

  @override
  int? getInt(String key) => _values[key] as int?;

  @override
  String? getString(String key) => _values[key] as String?;

  @override
  Future<void> init() async {}

  @override
  Future<void> remove(String key) async => _values.remove(key);

  @override
  Future<void> setBool(String key, bool value) async => _values[key] = value;

  @override
  Future<void> setDouble(String key, double value) async {
    _values[key] = value;
  }

  @override
  Future<void> setInt(String key, int value) async => _values[key] = value;

  @override
  Future<void> setString(String key, String value) async {
    _values[key] = value;
  }
}
