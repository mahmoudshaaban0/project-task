import 'package:app_template/theme/theme_ext.dart';
import 'package:flutter/cupertino.dart';

class AppSwitch extends StatelessWidget {
  const AppSwitch({
    required this.value,
    required this.onChanged,
    this.scale = 0.8,
    super.key,
  });
  final bool value;
  final void Function(bool) onChanged;
  final double? scale;
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale ?? 0.8,
      child: CupertinoSwitch(
        activeTrackColor: context.colors.primary,
        inactiveTrackColor: context.colors.surfaceContainerHigh,
        inactiveThumbColor: CupertinoColors.white,
        thumbColor: CupertinoColors.white,
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
