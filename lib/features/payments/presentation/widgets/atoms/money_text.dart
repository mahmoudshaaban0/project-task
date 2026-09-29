import 'package:flutter/material.dart';

/// Atom: an amount formatted for the current locale (`AED 1,200.00`).
///
/// Uses tabular figures so amounts line up and don't shift width as they
/// change.
class MoneyText extends StatelessWidget {
  const MoneyText(this.amount, {this.style, super.key});

  final String amount;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      amount,
      style: (style ?? DefaultTextStyle.of(context).style).copyWith(
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
