import 'package:clinic_app/models/appointments_model.dart';

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
