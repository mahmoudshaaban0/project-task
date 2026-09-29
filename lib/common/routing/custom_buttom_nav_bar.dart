import 'package:app_template/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CustomButtomNavBar extends StatelessWidget {
  const CustomButtomNavBar({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;
  // final bool hideNavigationBar;

  @override
  Widget build(BuildContext context) {
    return PersistentTabView.router(
      navigationShell: navigationShell,
      backgroundColor: context.colors.background,

      tabs: [
        PersistentRouterTabConfig(
          item: ItemConfig(
            icon: const Icon(Icons.home),
            inactiveIcon: const Icon(Icons.home_outlined),
            title: context.localizations.home,
            activeForegroundColor: context.colors.primary,
            inactiveForegroundColor: context.colors.textTertiary,
            textStyle: context.typography.medium12,
          ),
        ),
        PersistentRouterTabConfig(
          item: ItemConfig(
            icon: const Icon(Icons.receipt_long),
            inactiveIcon: const Icon(Icons.receipt_long_outlined),
            title: context.localizations.payments,
            activeForegroundColor: context.colors.primary,
            inactiveForegroundColor: context.colors.textTertiary,
            textStyle: context.typography.medium12,
          ),
        ),
      ],
      navBarBuilder: (navBarConfig) => Style1BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: NavBarDecoration(
          color: context.colors.surface,
          border: Border(top: BorderSide(color: context.colors.divider)),
          padding: const EdgeInsets.symmetric(vertical: 6),
        ),
      ),
    );
  }
}
