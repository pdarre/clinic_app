import 'package:clinic_app/models/medicine_model.dart';
import 'package:clinic_app/repositories/medicine_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class MedicineState {
  const MedicineState();
}

class MedicineInitial extends MedicineState {
  const MedicineInitial();
}

class MedicineLoading extends MedicineState {
  const MedicineLoading();
}

class MedicineError extends MedicineState {
  final String message;
  MedicineError(this.message);
}

class MedicineLoaded extends MedicineState {
  final Medicine medicine;
  final List<Medicine> medicineList;
  final List<String> medicineNameList;
  const MedicineLoaded(this.medicine, this.medicineList, this.medicineNameList);
}

class MedicineStateNotifierProvider extends StateNotifier<MedicineState> {
  final MedicineRepository _medicineRepository;
  MedicineStateNotifierProvider(this._medicineRepository)
      : super(MedicineInitial());

  // Future<void> getMedicineByIdMedicine(String idMedicine) async {
  //   var medicines = <Medicine>[];
  //   var medicineNameList = <String>[];
  //   state = MedicineInitial();
  //   try {
  //     state = MedicineLoading();
  //     await _medicineRepository.getMedicineByIdMedicine(idMedicine).then(
  //         (medicine) =>
  //             state = MedicineLoaded(medicine, medicines, medicineNameList));
  //   } on FirebaseException catch (e) {
  //     state = MedicineError('${e.message}');
  //   } catch (ex) {
  //     state = MedicineError('${ex.toString()}');
  //   }
  // }

  Future<Medicine> getMedicineByIdMedicine(String idMedicine) async {
    Medicine medicine;
    try {
      medicine = await _medicineRepository.getMedicineByIdMedicine(idMedicine);
    } on FirebaseException catch (e) {
      throw e;
    } catch (ex) {
      throw ex;
    }
    return medicine;
  }
}
