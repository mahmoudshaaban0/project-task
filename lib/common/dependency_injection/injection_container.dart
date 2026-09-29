import 'dart:async';

import 'package:app_template/common/authentication/device_authenticator.dart';
import 'package:app_template/common/networking/api_consumer.dart';
import 'package:app_template/common/networking/app_intercepters.dart';
import 'package:app_template/common/networking/dio_consumer.dart';
import 'package:app_template/common/networking/network_info.dart';
import 'package:app_template/common/storage/key_value_storage.dart';
import 'package:app_template/common/storage/shared_pref_storage.dart';
import 'package:app_template/features/payments/data/datasources/payment_remote_datasource.dart';
import 'package:app_template/features/payments/data/repositories/payments_repository.dart';
import 'package:app_template/features/payments/presentation/cubit/payments_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;
Future<void> init() async {
  sl
    //! Data Sources
    ..registerLazySingleton<PaymentsRemoteDataSource>(
      () => AssetPaymentDataSource(bundle: rootBundle),
    )
    //! Repositories
    ..registerLazySingleton<PaymentsRepository>(
      () => PaymentsRepositoryImpl(dataSource: sl()),
    )
    //! Features
    ..registerFactory<PaymentsCubit>(
      () {
        final cubit = PaymentsCubit(repository: sl());
        unawaited(cubit.loadPayments());
        return cubit;
      },
    )
    ///! Core
    ..registerLazySingleton<DeviceAuthenticator>(LocalDeviceAuthenticator.new)
    ..registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectivityChecker: sl()),
    )
    ..registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  final keyValueStorage = SharedPrefStorage();
  await keyValueStorage.init();
  sl
    ..registerLazySingleton<SharedPreferences>(() => sharedPreferences)
    ..registerLazySingleton<KeyValueStorage>(() => keyValueStorage)
    ..registerLazySingleton<AppIntercepters>(AppIntercepters.new)
    ..registerLazySingleton<PrettyDioLogger>(
      () => PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    )
    ..registerLazySingleton<InternetConnectionChecker>(
      InternetConnectionChecker.createInstance,
    )
    ..registerLazySingleton<Dio>(Dio.new);
}
