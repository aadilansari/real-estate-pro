import '../datasources/property_remote_datasource.dart';
import '../models/location_model.dart';
import '../models/property_model.dart';

/// Abstract contract — depend on this in BLoC, not the concrete impl.
abstract class PropertyRepository {
  Future<List<PropertyModel>> getProperties({
    String? city,
    String type = 'Rent',
  });

  Future<List<LocationModel>> getLocations();
}

/// Concrete implementation backed by [PropertyRemoteDataSource].
class PropertyRepositoryImpl implements PropertyRepository {
  final PropertyRemoteDataSource _dataSource;

  PropertyRepositoryImpl(this._dataSource);

  @override
  Future<List<PropertyModel>> getProperties({
    String? city,
    String type = 'Rent',
  }) =>
      _dataSource.fetchProperties(city: city, type: type);

  @override
  Future<List<LocationModel>> getLocations() => _dataSource.fetchLocations();
}
