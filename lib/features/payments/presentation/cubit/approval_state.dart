import 'package:equatable/equatable.dart';

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
