import 'package:equatable/equatable.dart';

abstract class PropertyEvent extends Equatable {
  const PropertyEvent();

  @override
  List<Object?> get props => [];
}

/// Triggered on app start and whenever the Rent/Sell/Upcoming tab changes.
class LoadProperties extends PropertyEvent {
  final String? city;

  /// One of: 'Rent', 'Sell', 'Upcoming'
  final String type;

  const LoadProperties({this.city, this.type = 'Rent'});

  @override
  List<Object?> get props => [city, type];
}

/// Triggered to refresh the list (pull-to-refresh).
class RefreshProperties extends PropertyEvent {
  final String? city;
  final String type;

  const RefreshProperties({this.city, this.type = 'Rent'});

  @override
  List<Object?> get props => [city, type];
}
