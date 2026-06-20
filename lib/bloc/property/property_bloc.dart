import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import '../../data/repositories/property_repository.dart';
import 'property_event.dart';
import 'property_state.dart';

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  final PropertyRepository _repository;

  PropertyBloc(this._repository) : super(const PropertyInitial()) {
    on<LoadProperties>(_onLoadProperties);
    on<RefreshProperties>(_onRefreshProperties);
  }

  Future<void> _onLoadProperties(
    LoadProperties event,
    Emitter<PropertyState> emit,
  ) async {
    emit(const PropertyLoading());
    try {
      final properties = await _repository.getProperties(
        city: event.city,
        type: event.type,
      );
      emit(PropertyLoaded(properties: properties, type: event.type));
    } catch (e) {
      debugPrint('[PropertyBloc] Error: $e');
      emit(PropertyError(e.toString()));
    }
  }

  Future<void> _onRefreshProperties(
    RefreshProperties event,
    Emitter<PropertyState> emit,
  ) async {
    // Keep existing list visible while refreshing
    if (state is PropertyLoaded) {
      emit(
        PropertyRefreshing(
          currentProperties: (state as PropertyLoaded).properties,
          type: event.type,
        ),
      );
    }
    try {
      final properties = await _repository.getProperties(
        city: event.city,
        type: event.type,
      );
      emit(PropertyLoaded(properties: properties, type: event.type));
    } catch (e) {
      debugPrint('[PropertyBloc] Refresh error: $e');
      emit(PropertyError(e.toString()));
    }
  }
}
