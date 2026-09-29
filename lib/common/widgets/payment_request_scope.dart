import 'package:flutter/material.dart';

/// Shared state (with a persisted position) used by the FABs rendered by each BaseScaffold.
class PaymentRequestScope extends InheritedWidget {
  const PaymentRequestScope({
    required this.position,
    required this.busy,
    required this.onRequest,
    required this.onPositionChanged,
    required this.onDragEnd,
    required super.child,
    super.key,
  });

  final Offset? position;
  final bool busy;
  final VoidCallback onRequest;
  final ValueChanged<Offset> onPositionChanged;
  final VoidCallback onDragEnd;

  static PaymentRequestScope? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<PaymentRequestScope>();

  @override
  bool updateShouldNotify(PaymentRequestScope oldWidget) =>
      position != oldWidget.position || busy != oldWidget.busy;
}
