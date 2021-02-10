import 'package:clinic_app/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final getUserLocationByIdPatientFutureProvider =
    FutureProvider.autoDispose.family<LatLng, String>((ref, idPatient) {
  return ref.watch(mapRepository).getPatientAddress(idPatient);
});
