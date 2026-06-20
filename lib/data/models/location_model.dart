import 'package:equatable/equatable.dart';

class LocationModel extends Equatable {
  final String name;
  final String imageUrl;

  const LocationModel({required this.name, required this.imageUrl});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'name': name, 'imageUrl': imageUrl};

  @override
  List<Object?> get props => [name, imageUrl];
}
