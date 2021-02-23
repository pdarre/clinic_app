import 'package:clinic_app/repositories/patient_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'patient_states.dart';

class PatientStateNotifierProvider extends StateNotifier<PatientState> {
  final PatientRepository _patientRepository;
  PatientStateNotifierProvider(this._patientRepository)
      : super(PatientInitial());

  // Future<void> getPatientById(String idPatient) async {
  //   var patientList = <MyUser>[];
  //   try {
  //     state = PatientLoading();
  //     await _patientRepository.getPatientById(idPatient).then((patient) {
  //       state = PatientLoaded(patient, patientList);
  //     });
  //   } on FirebaseException catch (e) {
  //     state = PatientError('${e.message}');
  //   } catch (ex) {
  //     state = PatientError('${ex.toString()}');
  //   }
  // }

  // Future<void> getAllPatients() async {
  //   MyUser patient;
  //   try {
  //     state = PatientLoading();
  //     await _patientRepository.getAllPatients().then((patientList) {
  //       state = PatientLoaded(patient, patientList);
  //     });
  //   } on FirebaseException catch (e) {
  //     state = PatientError('${e.message}');
  //   } catch (ex) {
  //     state = PatientError('${ex.toString()}');
  //   }
  // }
}
