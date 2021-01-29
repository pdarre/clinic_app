import 'package:clinic_app/models/beds_model.dart';
import 'package:clinic_app/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getBedByIdBedFutureProvider =
    FutureProvider.autoDispose.family<Bed, String>((ref, idBed) async {
  return await ref.watch(bedRepository).getBedByIdBed(idBed);
});
