import 'package:app_template/common/authentication/device_authenticator.dart';
import 'package:app_template/features/payments/presentation/cubit/approval_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class ApprovalCubit extends Cubit<ApprovalState> {
  ApprovalCubit({required this._authenticator}) : super(const ApprovalState());

  final DeviceAuthenticator _authenticator;

  Future<void> authenticate(String reason) async {
    if (state.isBusy || state.isRevealed) return;
    emit(const ApprovalState(status: ApprovalStatus.authenticating));

    try {
      final success = await _authenticator.authenticate(reason);
      if (isClosed) return;
      emit(
        ApprovalState(
          status: success ? ApprovalStatus.revealed : ApprovalStatus.failed,
        ),
      );
    } on Exception {
      if (!isClosed) {
        emit(const ApprovalState(status: ApprovalStatus.failed));
      }
    }
  }
}
