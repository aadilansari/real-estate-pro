import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../core/constants/api_constants.dart';
import '../../core/network/dio_client.dart';
import '../models/location_model.dart';
import '../models/property_model.dart';

abstract class PropertyRemoteDataSource {
  Future<List<PropertyModel>> fetchProperties({
    String? city,
    String type = 'Rent',
  });

  Future<List<LocationModel>> fetchLocations();
}

class PropertyRemoteDataSourceImpl implements PropertyRemoteDataSource {
  final DioClient _dioClient;

  PropertyRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<PropertyModel>> fetchProperties({
    String? city,
    String type = 'Rent',
  }) async {
    try {
      final response = await _dioClient.dio.get(
        ApiConstants.properties,
        queryParameters: {
          // ignore: use_null_aware_elements
          if (city != null) 'city': city,
          'type': type,
        },
      );

      final List<dynamic> data = response.data['data'] as List<dynamic>;
      return data
          .map((e) => PropertyModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      debugPrint('[PropertyRemoteDataSource] DioException: ${e.message}');
      debugPrint('[PropertyRemoteDataSource] Falling back to mock data.');
      return _mockProperties(type: type);
    } catch (e) {
      debugPrint('[PropertyRemoteDataSource] Unknown error: $e');
      return _mockProperties(type: type);
    }
  }

  @override
  Future<List<LocationModel>> fetchLocations() async {
    try {
      final response = await _dioClient.dio.get(ApiConstants.locations);
      final List<dynamic> data = response.data['data'] as List<dynamic>;
      return data
          .map((e) => LocationModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      debugPrint('[PropertyRemoteDataSource] DioException: ${e.message}');
      debugPrint('[PropertyRemoteDataSource] Falling back to mock locations.');
      return _mockLocations();
    } catch (e) {
      debugPrint('[PropertyRemoteDataSource] Unknown error: $e');
      return _mockLocations();
    }
  }

  // ── Mock data (mirrors existing hardcoded data) ────────────────────────────

  List<PropertyModel> _mockProperties({String type = 'Rent'}) => [
    const PropertyModel(
      id: '1',
      image:
          'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800',
      title: 'SNN Raj Eternia - Harlur',
      price: '60,000',
      location: 'Whitefield',
      sqft: '1080 sqft',
      floor: '9th Floor',
      furnishing: 'Fully Furnished',
      date: '25/12/2025',
      bhk: '3 BHK',
      availFrom: '25/12/2025',
      balcony: '2',
      bathroom: '2',
      deposit: '4 Lac',
      maintenance: '6000',
      tenantType: 'Anyone',
      brokerage: '5000',
    ),
    const PropertyModel(
      id: '2',
      image:
          'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=800',
      title: 'Prestige Lakeside - 2BHK Apartment',
      price: '45,000',
      location: 'Sarjapur',
      sqft: '950 sqft',
      floor: '3rd Floor',
      furnishing: 'Semi Furnished',
      date: '01/03/2026',
      bhk: '2 BHK',
      availFrom: '01/03/2026',
      balcony: '1',
      bathroom: '2',
      deposit: '2 Lac',
      maintenance: '4000',
      tenantType: 'Family',
      brokerage: '4500',
    ),
    const PropertyModel(
      id: '3',
      image:
          'https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=800',
      title: 'Brigade Metropolis - 3BHK Villa',
      price: '85,000',
      location: 'Marathahalli',
      sqft: '1450 sqft',
      floor: '2nd Floor',
      furnishing: 'Fully Furnished',
      date: '15/01/2026',
      bhk: '3 BHK',
      availFrom: '15/01/2026',
      balcony: '3',
      bathroom: '3',
      deposit: '6 Lac',
      maintenance: '8000',
      tenantType: 'Anyone',
      brokerage: '7000',
    ),
    const PropertyModel(
      id: '4',
      image:
          'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800',
      title: 'Sobha Dream Acres - 1BHK Studio',
      price: '25,000',
      location: 'Panathur',
      sqft: '620 sqft',
      floor: '7th Floor',
      furnishing: 'Semi Furnished',
      date: '10/02/2026',
      bhk: '1 BHK',
      availFrom: '10/02/2026',
      balcony: '1',
      bathroom: '1',
      deposit: '1.5 Lac',
      maintenance: '2500',
      tenantType: 'Bachelor',
      brokerage: '2500',
    ),
  ];

  List<LocationModel> _mockLocations() => const [
    LocationModel(
      name: 'Delhi',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Lotus_temple_compress.jpg/320px-Lotus_temple_compress.jpg',
    ),
    LocationModel(
      name: 'Agra',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Taj_Mahal%2C_Agra%2C_India_edit3.jpg/320px-Taj_Mahal%2C_Agra%2C_India_edit3.jpg',
    ),
    LocationModel(
      name: 'Mumbai',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Mumbai_03-2016_30_Gateway_of_India.jpg/320px-Mumbai_03-2016_30_Gateway_of_India.jpg',
    ),
    LocationModel(
      name: 'Delhi',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/India_Gate_in_New_Delhi_03-2016.jpg/320px-India_Gate_in_New_Delhi_03-2016.jpg',
    ),
  ];
}
