import 'package:clinic_app/models/users_model.dart';
import 'package:clinic_app/providers/appointment_provider.dart';
import 'package:clinic_app/providers/appointments_lists_provider.dart';
import 'package:clinic_app/providers/auth_provider.dart';
import 'package:clinic_app/providers/medicine_provider.dart';
import 'package:clinic_app/providers/patient_provider.dart';
import 'package:clinic_app/providers/stream_appointments.dart';
import 'package:clinic_app/repositories/appointment_repository.dart';
import 'package:clinic_app/repositories/auth_repository.dart';
import 'package:clinic_app/repositories/medicine_repository.dart';
import 'package:clinic_app/repositories/patient_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepository = Provider<AuthRepository>((ref) => AuthRepository());

final appointmentRepository =
    Provider<AppointmentRepository>((ref) => AppointmentRepository());

final patientRepository =
    Provider<PatientRepository>((ref) => PatientRepository());

final medicineRepository =
    Provider<MedicineRepository>((ref) => MedicineRepository());

//provide acces to StreamAppointments class
final streamAppointments = Provider<StreamAppointments>(
  (ref) => StreamAppointments(),
);

final authProvider = StateNotifierProvider(
    (ref) => AuthStateNotifierProvider(ref.watch(authRepository)));

final appointmentsProvider = StateNotifierProvider(
    (ref) => AppointmentNotifierProvider(ref.watch(appointmentRepository)));

final appointmentsListProvider = StateNotifierProvider((ref) =>
    AppointmentsListNotifierProvider(ref.watch(appointmentRepository)));

final patientProvider = StateNotifierProvider.autoDispose(
    (ref) => PatientStateNotifierProvider(ref.watch(patientRepository)));

final medicineProvider = StateNotifierProvider(
    (ref) => MedicineStateNotifierProvider(ref.watch(medicineRepository)));

final userAuthStream = StreamProvider<User>((ref) {
  return ref.watch(authRepository).authStateChanges;
});

final appointmentsStream = StreamProvider.autoDispose<QuerySnapshot>((ref) {
  var uid = FirebaseAuth.instance.currentUser.uid;
  return ref.watch(streamAppointments).getAppointments(uid);
});

final getFutureMyUser = FutureProvider.autoDispose<MyUser>((ref) async {
  final myUser = await ref.watch(authProvider).findCurrentMyUser();
  return myUser;
});
