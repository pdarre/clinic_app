import 'package:clinic_app/models/appointments_model.dart';
import 'package:clinic_app/repositories/appointment_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AppointmentListState {
  const AppointmentListState();
}

class AppointmentListInitial implements AppointmentListState {
  const AppointmentListInitial();
}

class AppointmentListLoading implements AppointmentListState {
  const AppointmentListLoading();
}

class AppointmentListError implements AppointmentListState {
  final String message;
  const AppointmentListError(this.message);
}

class AppointmentListLoaded implements AppointmentListState {
  final List<Appointment> appointmentsList;
  const AppointmentListLoaded(this.appointmentsList);
}

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
