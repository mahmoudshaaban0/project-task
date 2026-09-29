import 'package:app_template/common/authentication/device_authenticator.dart';
import 'package:app_template/common/constants/app_constants.dart';
import 'package:app_template/common/dependency_injection/injection_container.dart';
import 'package:app_template/common/routing/app_router.dart';
import 'package:app_template/common/routing/app_routes.dart';
import 'package:app_template/common/storage/key_value_storage.dart';
import 'package:app_template/features/payments/presentation/cubit/payments_cubit.dart';
import 'package:app_template/features/payments/presentation/widgets/payment_request_overlay.dart';
import 'package:app_template/l10n/app_localizations.dart';
import 'package:app_template/theme/app_theme_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectTask extends StatelessWidget {
  const ProjectTask({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppThemeScope.of(context);
    return BlocProvider(
      create: (_) => sl<PaymentsCubit>(),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            routerConfig: AppRouter.router,
            builder: (context, child) => PaymentRequestOverlay(
              navigatorKey: navigatorKey,
              storage: sl<KeyValueStorage>(),
              authenticator: sl<DeviceAuthenticator>(),
              onApproved: () => AppRouter.router.goNamed(
                AppRoutes.payments.name,
              ),
              child: child!,
            ),
            debugShowCheckedModeBanner: false,
            title: AppConstants.appName,
            themeMode: theme!.themeMode,
            locale: const Locale(AppConstants.english),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale(
                AppConstants.english,
              ),
              Locale(
                AppConstants.arabic,
              ),
            ],
            // ThemeScopeWidget already resolved light/dark into theme.theme.
            theme: theme.theme.materialTheme,
            darkTheme: theme.theme.materialTheme,
          );
        },
      ),
    );
  }
}
