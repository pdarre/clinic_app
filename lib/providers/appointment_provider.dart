import 'package:clinic_app/models/appointments_model.dart';
import 'package:clinic_app/repositories/appointment_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AppointmentState {
  const AppointmentState();
}

class AppointmentInitial implements AppointmentState {
  const AppointmentInitial();
}

class AppointmentLoading implements AppointmentState {
  const AppointmentLoading();
}

class AppointmentError implements AppointmentState {
  final String message;
  const AppointmentError(this.message);
}

class AppointmentLoaded implements AppointmentState {
  final Appointment appointment;
  const AppointmentLoaded(this.appointment);
}

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
    } catch (e) {
      state = AppointmentError(e.toString());
    }
  }
}
