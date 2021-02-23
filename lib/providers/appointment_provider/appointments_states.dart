import 'package:clinic_app/models/appointments_model.dart';

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
