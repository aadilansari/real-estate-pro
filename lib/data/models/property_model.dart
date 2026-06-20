import 'package:equatable/equatable.dart';

class PropertyModel extends Equatable {
  final String id;
  final String image;
  final String title;
  final String price;
  final String location;
  final String sqft;
  final String floor;
  final String furnishing;
  final String availFrom;
  final String bhk;
  final String balcony;
  final String bathroom;
  final String deposit;
  final String maintenance;
  final String tenantType;
  final String brokerage;
  final String date;

  const PropertyModel({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.location,
    required this.sqft,
    required this.floor,
    required this.furnishing,
    required this.availFrom,
    required this.bhk,
    required this.balcony,
    required this.bathroom,
    required this.deposit,
    required this.maintenance,
    required this.tenantType,
    required this.brokerage,
    required this.date,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id']?.toString() ?? '',
      image: json['image'] as String? ?? '',
      title: json['title'] as String? ?? '',
      price: json['price']?.toString() ?? '',
      location: json['location'] as String? ?? '',
      sqft: json['sqft']?.toString() ?? '',
      floor: json['floor'] as String? ?? '',
      furnishing: json['furnishing'] as String? ?? '',
      availFrom: json['availFrom'] as String? ?? '',
      bhk: json['bhk'] as String? ?? '',
      balcony: json['balcony']?.toString() ?? '',
      bathroom: json['bathroom']?.toString() ?? '',
      deposit: json['deposit']?.toString() ?? '',
      maintenance: json['maintenance']?.toString() ?? '',
      tenantType: json['tenantType'] as String? ?? '',
      brokerage: json['brokerage']?.toString() ?? '',
      date: json['date'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'image': image,
    'title': title,
    'price': price,
    'location': location,
    'sqft': sqft,
    'floor': floor,
    'furnishing': furnishing,
    'availFrom': availFrom,
    'bhk': bhk,
    'balcony': balcony,
    'bathroom': bathroom,
    'deposit': deposit,
    'maintenance': maintenance,
    'tenantType': tenantType,
    'brokerage': brokerage,
    'date': date,
  };

  @override
  List<Object?> get props => [id, title, price, location];
}
