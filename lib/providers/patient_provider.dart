import 'package:clinic_app/models/users_model.dart';
import 'package:clinic_app/repositories/patient_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class PatientStateNotifierProvider extends StateNotifier<PatientState> {
  final PatientRepository _patientRepository;
  PatientStateNotifierProvider(this._patientRepository)
      : super(PatientInitial());

  Future<void> getPatientById(String idPatient) async {
    var patientList = <MyUser>[];
    try {
      state = PatientLoading();
      await _patientRepository.getPatientById(idPatient).then((patient) {
        state = PatientLoaded(patient, patientList);
      });
    } on FirebaseException catch (e) {
      state = PatientError('${e.message}');
    } catch (ex) {
      state = PatientError('${ex.toString()}');
    }
  }

  Future<void> getAllPatients() async {
    MyUser patient;
    try {
      state = PatientLoading();
      await _patientRepository.getAllPatients().then((patientList) {
        state = PatientLoaded(patient, patientList);
      });
    } on FirebaseException catch (e) {
      state = PatientError('${e.message}');
    } catch (ex) {
      state = PatientError('${ex.toString()}');
    }
  }
}
