import 'package:clinic_app/repositories/map_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'map_states.dart';

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
