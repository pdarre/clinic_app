import 'package:clinic_app/models/appointments_model.dart';
import 'package:clinic_app/repositories/appointment_repository.dart';
import 'package:firebase_core/firebase_core.dart';
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
    } on FirebaseException catch (e) {
      state = AppointmentError('${e.message}');
    } catch (ex) {
      state = AppointmentError('${ex.toString()}');
    }
  }

  Future<void> updateAppointment(Appointment appointment) async {
//probar si se puede usar appointment desde el state q esta ya cargado, quizas haciendo una copia de state??
//investigar si funciona la nueva copia de appointment en el estado con copyWith
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
