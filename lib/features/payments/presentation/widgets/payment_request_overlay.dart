import 'dart:async';
import 'dart:convert';

import 'package:app_template/common/authentication/device_authenticator.dart';
import 'package:app_template/common/constants/app_constants.dart';
import 'package:app_template/common/storage/key_value_storage.dart';
import 'package:app_template/common/widgets/atoms/bottom_sheet_wrapper.dart';
import 'package:app_template/common/widgets/payment_request_scope.dart';
import 'package:app_template/features/payments/data/models/payment_response_model.dart';
import 'package:app_template/features/payments/presentation/cubit/approval_cubit.dart';
import 'package:app_template/features/payments/presentation/cubit/payments_cubit.dart';
import 'package:app_template/features/payments/presentation/widgets/approval_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Owns shared FAB state while BaseScaffold renders the button on each route.
class PaymentRequestOverlay extends StatefulWidget {
  const PaymentRequestOverlay({
    required this.child,
    required this.navigatorKey,
    required this.storage,
    required this.authenticator,
    required this.onApproved,
    super.key,
  });

  final Widget child;
  final GlobalKey<NavigatorState> navigatorKey;
  final KeyValueStorage storage;
  final DeviceAuthenticator authenticator;
  final VoidCallback onApproved;

  @override
  State<PaymentRequestOverlay> createState() => _PaymentRequestOverlayState();
}

class _PaymentRequestOverlayState extends State<PaymentRequestOverlay> {
  Offset? _position;
  var _reviewing = false;

  @override
  void initState() {
    super.initState();
    _position = _restorePosition();
  }

  Offset? _restorePosition() {
    try {
      final saved = widget.storage.getString(
        AppConstants.positionPreferenceKey,
      );
      if (saved == null) return null;
      final decoded = jsonDecode(saved);
      if (decoded is! List || decoded.length != 2) return null;
      final x = decoded[0];
      final y = decoded[1];
      if (x is! num || y is! num || !x.isFinite || !y.isFinite) return null;
      return Offset(x.toDouble(), y.toDouble());
    } on FormatException {
      return null;
    }
  }

  Future<void> _openApprovalSheet() async {
    if (_reviewing) return;
    if (widget.navigatorKey.currentState?.overlay == null) return;

    final paymentsCubit = context.read<PaymentsCubit>();
    setState(() => _reviewing = true);
    final request = await paymentsCubit.createRequest();
    if (!mounted) return;
    if (request == null) {
      setState(() => _reviewing = false);
      return;
    }

    final sheetContext = widget.navigatorKey.currentState?.overlay?.context;
    if (sheetContext == null) {
      await paymentsCubit.discardPending(request.id);
      if (mounted) setState(() => _reviewing = false);
      return;
    }
    if (!sheetContext.mounted) return;
    final decision = await BottomSheetWrapper.show<PaymentStatus>(
      context: sheetContext,
      builder: (_) => BlocProvider(
        create: (_) => ApprovalCubit(authenticator: widget.authenticator),
        child: ApprovalSheet(payment: request),
      ),
    );
    if (!mounted) return;

    setState(() => _reviewing = false);
    if (decision == PaymentStatus.approved) {
      final approved = await paymentsCubit.approve(request.id);
      if (approved && mounted) widget.onApproved();
    } else if (decision == PaymentStatus.rejected) {
      await paymentsCubit.reject(request.id);
    } else {
      await paymentsCubit.discardPending(request.id);
    }
  }

  void _savePosition() {
    final position = _position;
    if (position == null) return;
    unawaited(
      widget.storage.setString(
        AppConstants.positionPreferenceKey,
        jsonEncode([position.dx, position.dy]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => PaymentRequestScope(
    position: _position,
    busy: _reviewing,
    onRequest: () => unawaited(_openApprovalSheet()),
    onPositionChanged: (position) => setState(() => _position = position),
    onDragEnd: _savePosition,
    child: widget.child,
  );
}
