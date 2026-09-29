import 'dart:math' as math;

import 'package:app_template/common/widgets/payment_request_scope.dart';
import 'package:app_template/theme/theme_ext.dart';
import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({required this.body, this.appBar, super.key});
  final Widget body;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    final requestScope = PaymentRequestScope.maybeOf(context);
    return Scaffold(
      appBar: appBar,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.noAnimation,
      floatingActionButtonLocation: _RequestFabLocation(
        requestScope?.position,
      ),
      floatingActionButton: requestScope == null
          ? null
          : Builder(
              builder: (buttonContext) => GestureDetector(
                onPanEnd: (_) => requestScope.onDragEnd(),
                onPanCancel: requestScope.onDragEnd,
                onPanUpdate: (details) {
                  final button = buttonContext.findRenderObject()! as RenderBox;
                  final scaffold =
                      Scaffold.of(buttonContext).context.findRenderObject()!
                          as RenderBox;
                  final position = scaffold.globalToLocal(
                    button.localToGlobal(Offset.zero),
                  );
                  final padding = MediaQuery.paddingOf(buttonContext);
                  final next = position + details.delta;
                  requestScope.onPositionChanged(
                    Offset(
                      next.dx.clamp(
                        padding.left + 8,
                        math.max(
                          padding.left + 8,
                          scaffold.size.width -
                              button.size.width -
                              padding.right -
                              8,
                        ),
                      ),
                      next.dy.clamp(
                        padding.top + 8,
                        math.max(
                          padding.top + 8,
                          scaffold.size.height -
                              button.size.height -
                              padding.bottom -
                              8,
                        ),
                      ),
                    ),
                  );
                },
                child: FloatingActionButton(
                  key: const ValueKey('payment-request-fab'),
                  // Retained tab scaffolds must not share the default Hero tag.
                  heroTag: null,
                  tooltip: context.localizations.newPaymentRequest,
                  onPressed: requestScope.busy ? null : requestScope.onRequest,
                  child: const Icon(Icons.add),
                ),
              ),
            ),
      body: body,
    );
  }
}

class _RequestFabLocation extends FloatingActionButtonLocation {
  const _RequestFabLocation(this.position);
  final Offset? position;

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry geometry) {
    final offset =
        position ?? FloatingActionButtonLocation.endFloat.getOffset(geometry);
    final padding = geometry.minInsets;
    final size = geometry.floatingActionButtonSize;
    return Offset(
      offset.dx.clamp(
        padding.left + 8,
        math.max(
          padding.left + 8,
          geometry.scaffoldSize.width - size.width - padding.right - 8,
        ),
      ),
      offset.dy.clamp(
        padding.top + 8,
        math.max(
          padding.top + 8,
          geometry.scaffoldSize.height - size.height - padding.bottom - 8,
        ),
      ),
    );
  }
}
