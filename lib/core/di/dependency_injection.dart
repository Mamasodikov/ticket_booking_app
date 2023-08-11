import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_booking_app/core/database/isar_service.dart';
import 'package:ticket_booking_app/core/network/network_info.dart';
import 'package:ticket_booking_app/core/utils/app_constants.dart';
import 'package:ticket_booking_app/auth/login/data/datasources/login_remote_datasources.dart';
import 'package:ticket_booking_app/auth/login/data/repositories/login_repository_impl.dart';
import 'package:ticket_booking_app/auth/login/domain/repositories/login_repository.dart';
import 'package:ticket_booking_app/auth/login/domain/usescases/u_login.dart';
import 'package:ticket_booking_app/auth/login/presentation/bloc/login_bloc.dart';
import 'package:ticket_booking_app/auth/register/data/datasources/register_remote_datasources.dart';
import 'package:ticket_booking_app/auth/register/data/repositories/register_repository_impl.dart';
import 'package:ticket_booking_app/auth/register/domain/repositories/register_repository.dart';
import 'package:ticket_booking_app/auth/register/domain/usescases/u_login.dart';
import 'package:ticket_booking_app/auth/register/presentation/bloc/register_bloc.dart';
import 'package:ticket_booking_app/events/data/datasources/events_local_datasources.dart';
import 'package:ticket_booking_app/events/data/datasources/events_remote_datasources.dart';
import 'package:ticket_booking_app/events/data/repositories/events_repository_impl.dart';
import 'package:ticket_booking_app/events/domain/repository/events_repository.dart';
import 'package:ticket_booking_app/events/domain/usescases/u_events.dart';
import 'package:ticket_booking_app/events/presentation/bloc/events_bloc.dart';
import 'package:ticket_booking_app/reservations/data/datasources/reserves_local_datasources.dart';
import 'package:ticket_booking_app/reservations/data/datasources/reserves_remote_datasources.dart';
import 'package:ticket_booking_app/reservations/data/repositories/reserves_repository_impl.dart';
import 'package:ticket_booking_app/reservations/domain/repository/reserves_repository.dart';
import 'package:ticket_booking_app/reservations/domain/usescases/u_reserves.dart';
import 'package:ticket_booking_app/reservations/presentation/bloc/reserve_bloc.dart';

final di = GetIt.instance;
//di is referred to as Service Locator

Future<void> init() async {
  print('=========== Dependency injection initializing.... ===========');

  /// Blocs

  // // password
  // di.registerFactory(
  //   () => PinBloc(
  //     sharedPreferences: di(),
  //   ),
  // );
  // //lock
  // di.registerFactory(
  //   () => PassBloc(
  //     pass: di(),
  //   ),
  // );

  //login
  di.registerFactory(
    () => LoginBloc(loginData: di()),
  );

  //register
  di.registerFactory(
    () => RegisterBloc(registerData: di()),
  );

  //events
  di.registerFactory(
        () => EventsBloc(create: di(), update: di(), delete: di(), reserve: di(), events: di()),
  );

  //reserves
  di.registerFactory(
        () => ReservesBloc(update: di(), delete: di(), pay: di(), reserves: di()),
  );

  ///Repositories

  // login
  di.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(
        networkInfo: di(),
        loginRemoteDatasource: di(),
      ));
  // register
  di.registerLazySingleton<RegisterRepository>(() => RegisterRepositoryImpl(
        networkInfo: di(),
        registerRemoteDatasource: di(),
      ));

  // events
  di.registerLazySingleton<EventsRepository>(() => EventsRepositoryImpl(
        networkInfo: di(),
        eventsRemoteDatasourceImpl: di(),
        eventsLocalDatasourceImpl: di(),
      ));


  // reserves
  di.registerLazySingleton<ReservesRepository>(() => ReservesRepositoryImpl(
    networkInfo: di(),
    reservesRemoteDatasourceImpl: di(),
    reservesLocalDatasourceImpl: di(),
  ));

  // // profile
  // di.registerLazySingleton(
  //   () => ProfRepositoryImpl(
  //       networkInfo: di(),
  //       profRemoteDatasource: di(),
  //       profLocalDatasource: di()),
  // );
  //
  // // lock
  // di.registerLazySingleton<PassRepository>(
  //   () => PassRepositoryImpl(passLocalDataSource: di()),
  // );

  /// UsesCases

  // // lock
  // di.registerLazySingleton(() => Pass(repository: di()));

  //login
  di.registerLazySingleton(() => LoginData(loginRepository: di()));

  //register
  di.registerLazySingleton(() => RegisterData(registerRepository: di()));

  //events
  di.registerLazySingleton(() => UEvents(eventsRepository: di()));
  di.registerLazySingleton(() => UCreate(eventsRepository: di()));
  di.registerLazySingleton(() => UUpdate(eventsRepository: di()));
  di.registerLazySingleton(() => UDelete(eventsRepository: di()));
  di.registerLazySingleton(() => UReserve(eventsRepository: di()));


  //reserves
  di.registerLazySingleton(() => UReserves(reservesRepository: di()));
  di.registerLazySingleton(() => URUpdate(reservesRepository: di()));
  di.registerLazySingleton(() => URDelete(reservesRepository: di()));
  di.registerLazySingleton(() => URPay(reservesRepository: di()));

  // //profile
  // di.registerLazySingleton(() => ProfData(profRepository: di()));

  /// Data sources

  // //lock
  // di.registerLazySingleton(
  //   () => PassLocalDataSourceImpl(sharedPreferences: di()),
  // );

  //login
  di.registerLazySingleton(
    () => LoginRemoteDatasourceImpl(client: di()),
  );

  //register
  di.registerLazySingleton(
    () => RegisterRemoteDatasourceImpl(client: di()),
  );

  //events
  di.registerLazySingleton(
        () => EventsRemoteDatasourceImpl(dio: di(), prefs: di()),
  );
  di.registerLazySingleton(
        () => EventsLocalDataSourcesImpl(),
  );

  //reserves
  di.registerLazySingleton(
        () => ReservesRemoteDatasourceImpl(dio: di(), prefs: di()),
  );
  di.registerLazySingleton(
        () => ReservesLocalDataSourcesImpl(),
  );

  // //profile
  // di.registerLazySingleton(
  //   () =>
  //       ProfRemoteDatasourceImpl(sharedPreferences: di(), client: di()),
  // );
  // di.registerLazySingleton(
  //   () => ProfileLocalDataSourcesImpl(),
  // );

  ///***************************************************************************

  /// Network
  di.registerLazySingleton<http.Client>(() => http.Client());
  di.registerLazySingleton<Dio>(() => Dio());

  /// Network Info
  di.registerLazySingleton(() => InternetConnectionChecker());
  di.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(di()));

  /// Local cache
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  di.registerLazySingleton(() => prefs);

  final IsarService isar = await IsarService.buildIsarService();
  di.registerLazySingleton(() => isar);

  ///Versioning
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  version = packageInfo.version;

  print('=========== Dependency injection initializing completed! ===========');
}
