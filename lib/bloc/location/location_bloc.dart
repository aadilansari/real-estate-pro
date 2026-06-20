import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import '../../data/repositories/property_repository.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final PropertyRepository _repository;

  LocationBloc(this._repository) : super(const LocationInitial()) {
    on<LoadLocations>(_onLoadLocations);
  }

  Future<void> _onLoadLocations(
    LoadLocations event,
    Emitter<LocationState> emit,
  ) async {
    emit(const LocationLoading());
    try {
      final locations = await _repository.getLocations();
      emit(LocationLoaded(locations));
    } catch (e) {
      debugPrint('[LocationBloc] Error: $e');
      emit(LocationError(e.toString()));
    }
  }
}
