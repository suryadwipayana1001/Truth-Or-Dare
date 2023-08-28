import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truthordare/core/data/datasources/truthordare_datasource.dart';
import 'package:truthordare/core/data/repositories/truthordare_repositories.dart';
import '../core.dart';
import '../domain/usecase/truthordare_usecase.dart';
import '../network/network_info.dart';
import '../presentation/providers/core_provider.dart';
import '../presentation/providers/loading_provider.dart';

final locator = GetIt.instance;
Future<void> locatorInit() async {
  //Provider
  locator.registerFactory<LoadingProvider>(() => LoadingProvider());
  locator.registerFactory<CoreProvider>(
      () => CoreProvider(truthOrDare: locator()));
  //DataSource
  locator.registerLazySingleton<TruthOrDareDataSource>(
      () => TruthOrDareDataSourceImplementation(dio: locator<Dio>()));
  //Repositories
  locator.registerLazySingleton<TruthOrDareRepository>(
    () => TruthOrDareRepositoryImplementation(
      dataSource: locator(),
      networkInfo: locator(),
    ),
  );
  //UseCase
  locator.registerLazySingleton<TruthOrDare>(() => TruthOrDare(locator()));
  //NetworkInfo
  locator.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImplementation(locator<Connectivity>()));
  //Exsternal
  locator.registerLazySingleton<Dio>(() => DioClient().dio);
  locator.registerLazySingleton<Connectivity>(() => Connectivity());
  locator.registerLazySingletonAsync<Session>(() async =>
      SessionHelper(pref: await locator.getAsync<SharedPreferences>()));
  locator.registerLazySingletonAsync<SharedPreferences>(
      () async => await SharedPreferences.getInstance());
  locator.registerLazySingleton<GlobalKey<NavigatorState>>(
      () => GlobalKey<NavigatorState>());
}
