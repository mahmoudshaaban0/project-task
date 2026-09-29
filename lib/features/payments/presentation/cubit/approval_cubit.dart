import 'package:app_template/common/authentication/device_authenticator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ApprovalStatus { locked, authenticating, revealed, failed }

final class ApprovalState extends Equatable {
  const ApprovalState({this.status = ApprovalStatus.locked});

  final ApprovalStatus status;

  bool get isBusy => status == ApprovalStatus.authenticating;

  bool get isRevealed => status == ApprovalStatus.revealed;

  bool get hasFailed => status == ApprovalStatus.failed;

  @override
  List<Object> get props => [status];
}

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
