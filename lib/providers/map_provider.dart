import 'package:clinic_app/repositories/map_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapState {
  const MapState();
}

class MapInitial extends MapState {
  const MapInitial();
}

class MapLoading extends MapState {
  const MapLoading();
}

class MapError extends MapState {
  final String message;
  MapError(this.message);
}

class MapLoaded extends MapState {
  final LatLng userPosition;
  const MapLoaded(this.userPosition);
}

class MapStateNotifierProvider extends StateNotifier<MapState> {
  final MapRepository _mapRepository;
  MapStateNotifierProvider(this._mapRepository) : super(MapInitial());

  Future<void> getPatientAddress(String idPatient) async {
    state = MapInitial();
    try {
      state = MapLoading();
      final patientAddress = await _mapRepository.getPatientAddress(idPatient);
      state = MapLoaded(patientAddress);
    } catch (e) {
      state = MapError(e.toString());
    }
  }
}
