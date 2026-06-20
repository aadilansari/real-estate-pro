import 'package:equatable/equatable.dart';
import '../../data/models/property_model.dart';

abstract class PropertyState extends Equatable {
  const PropertyState();

  @override
  List<Object?> get props => [];
}

class PropertyInitial extends PropertyState {
  const PropertyInitial();
}

class PropertyLoading extends PropertyState {
  const PropertyLoading();
}

class PropertyLoaded extends PropertyState {
  final List<PropertyModel> properties;
  final String type;

  const PropertyLoaded({required this.properties, required this.type});

  @override
  List<Object?> get props => [properties, type];
}

class PropertyError extends PropertyState {
  final String message;

  const PropertyError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Emitted during a silent refresh (keeps old list visible while re-fetching).
class PropertyRefreshing extends PropertyState {
  final List<PropertyModel> currentProperties;
  final String type;

  const PropertyRefreshing({
    required this.currentProperties,
    required this.type,
  });

  @override
  List<Object?> get props => [currentProperties, type];
}
