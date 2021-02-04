import 'package:clinic_app/models/users_model.dart';
import 'package:clinic_app/providers.dart';
import 'package:flutter_riverpod/all.dart';

final getAllPatientsFutureProvider = FutureProvider<List<MyUser>>((ref) async {
  return await ref.watch(patientRepository).getAllPatients();
});