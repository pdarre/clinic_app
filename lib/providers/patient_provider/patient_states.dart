import 'package:clinic_app/models/users_model.dart';

abstract class PatientState {
  const PatientState();
}

class PatientInitial extends PatientState {
  const PatientInitial();
}

class PatientLoading extends PatientState {
  const PatientLoading();
}

class PatientError extends PatientState {
  final String message;
  const PatientError(this.message);
}

class PatientLoaded extends PatientState {
  final MyUser patient;
  final List<MyUser> patientList;
  PatientLoaded(this.patient, this.patientList);
}
