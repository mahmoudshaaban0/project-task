import 'package:app_template/common/authentication/device_authenticator.dart';
import 'package:app_template/features/payments/presentation/cubit/approval_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'emits authenticating then revealed when authentication succeeds',
    () async {
    final cubit = ApprovalCubit(
      authenticator: const _FakeAuthenticator(result: true),
      );
      addTearDown(cubit.close);
      final states = expectLater(
        cubit.stream,
        emitsInOrder(const [
          ApprovalState(status: ApprovalStatus.authenticating),
          ApprovalState(status: ApprovalStatus.revealed),
        ]),
      );

      await cubit.authenticate('Reveal payment');

      await states;
    },
  );

  test('emits failed when the authenticator throws', () async {
    final cubit = ApprovalCubit(authenticator: _ThrowingAuthenticator());
    addTearDown(cubit.close);

    await cubit.authenticate('Reveal payment');

    expect(cubit.state.status, ApprovalStatus.failed);
  });
}

final class _FakeAuthenticator implements DeviceAuthenticator {
  const _FakeAuthenticator({required this.result});

  final bool result;

  @override
  Future<bool> authenticate(String reason) async => result;
}

final class _ThrowingAuthenticator implements DeviceAuthenticator {
  @override
  Future<bool> authenticate(String reason) {
    throw Exception('Authentication unavailable');
  }
}
