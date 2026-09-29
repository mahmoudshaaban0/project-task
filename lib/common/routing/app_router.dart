import 'package:app_template/common/routing/app_routes.dart';
import 'package:app_template/common/routing/custom_buttom_nav_bar.dart';
import 'package:app_template/features/home/presentation/screen/home_screen.dart';
import 'package:app_template/features/payments/presentation/cubit/payments_cubit.dart';
import 'package:app_template/features/payments/presentation/screen/payment_details_screen.dart';
import 'package:app_template/features/payments/presentation/screen/payment_not_available_screen.dart';
import 'package:app_template/features/payments/presentation/screen/payments_screen.dart';
import 'package:app_template/features/splash/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// navigatorKey
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRoutes.splash.path,
    routes: [
      GoRoute(
        path: AppRoutes.splash.path,
        name: AppRoutes.splash.name,
        builder: (context, state) => const SplashScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => CustomButtomNavBar(
          navigationShell: navigationShell,
        ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoutes.home.name,
                path: AppRoutes.home.path,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoutes.payments.name,
                path: AppRoutes.payments.path,
                builder: (context, state) => const PaymentsScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        name: AppRoutes.paymentDetails.name,
        path: AppRoutes.paymentDetails.path,
        builder: (context, state) {
          final id = state.pathParameters['id'];
          final payment = id == null
              ? null
              : context.read<PaymentsCubit>().state.decidedPaymentById(id);
          return payment == null
              ? const PaymentNotAvailableScreen()
              : PaymentDetailsScreen(payment: payment);
        },
      ),
    ],
  );
}
