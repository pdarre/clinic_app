import 'package:clinic_app/repositories/appointment_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'appointments_list_states.dart';

class AppointmentsListNotifierProvider
    extends StateNotifier<AppointmentListState> {
  final AppointmentRepository _appointmentRepository;
  AppointmentsListNotifierProvider(this._appointmentRepository)
      : super(AppointmentListInitial());

  Future<void> getAppointmentsByIdDoctor(String idDoctor) async {
    try {
      state = AppointmentListLoading();
      final appointmentsList =
          await _appointmentRepository.getAppointmentsByIdDoctor(idDoctor);
      state = AppointmentListLoaded(appointmentsList);
    } on FirebaseException catch (e) {
      state = AppointmentListError('${e.message}');
    } catch (ex) {
      state = AppointmentListError('${ex.toString()}');
    }
  }
}
