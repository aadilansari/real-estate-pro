import 'package:get_it/get_it.dart';
import '../../bloc/location/location_bloc.dart';
import '../../bloc/property/property_bloc.dart';
import '../../data/datasources/property_remote_datasource.dart';
import '../../data/repositories/property_repository.dart';
import '../network/dio_client.dart';

final GetIt sl = GetIt.instance;

/// Call once in [main] before [runApp].
void setupInjection() {
  // ── Network ────────────────────────────────────────────────────────────────
  sl.registerLazySingleton<DioClient>(() => DioClient());

  // ── Data sources ──────────────────────────────────────────────────────────
  sl.registerLazySingleton<PropertyRemoteDataSource>(
    () => PropertyRemoteDataSourceImpl(sl<DioClient>()),
  );

  // ── Repositories ──────────────────────────────────────────────────────────
  sl.registerLazySingleton<PropertyRepository>(
    () => PropertyRepositoryImpl(sl<PropertyRemoteDataSource>()),
  );

  // ── BLoCs (factory = new instance per consumer) ───────────────────────────
  sl.registerFactory<PropertyBloc>(
    () => PropertyBloc(sl<PropertyRepository>()),
  );

  sl.registerFactory<LocationBloc>(
    () => LocationBloc(sl<PropertyRepository>()),
  );
}
