import 'package:clinic_app/models/appointments_model.dart';
import 'package:clinic_app/repositories/appointment_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'appointments_states.dart';

class AppointmentNotifierProvider extends StateNotifier<AppointmentState> {
  final AppointmentRepository _appointmentRepository;

  AppointmentNotifierProvider(this._appointmentRepository)
      : super(AppointmentInitial());

  Future<void> getAppointmentById(String idAppointment) async {
    try {
      state = AppointmentLoading();
      final appointment =
          await _appointmentRepository.getAppointmentById(idAppointment);
      state = AppointmentLoaded(appointment);
    } on FirebaseException catch (e) {
      state = AppointmentError('${e.message}');
    } catch (ex) {
      state = AppointmentError('${ex.toString()}');
    }
  }

  Future<void> updateAppointment(Appointment appointment) async {
    try {
      state = AppointmentLoading();
      await _appointmentRepository.updateAppointment(appointment);
      state = AppointmentLoaded(appointment);
    } on FirebaseException catch (e) {
      state = AppointmentError('${e.message}');
    } catch (ex) {
      state = AppointmentError('${ex.toString()}');
    }
  }
}
