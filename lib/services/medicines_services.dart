import 'package:clinic_app/models/medicine_model.dart';
import 'package:clinic_app/providers.dart';
import 'package:flutter_riverpod/all.dart';

// final getMedicineListStringByIdPatientIdFutureProvider = FutureProvider.autoDispose
//     .family<List<String>, String>((ref, idPatient) async {
//   return ref.watch(medicineRepository).getMedicineListByIdPatient(idPatient);
// });

final getMedicineListStringByIdPatientIdFutureProvider = FutureProvider
    .autoDispose
    .family<List<Medicine>, String>((ref, idPatient) async {
  var medicineList = List<Medicine>();
  await ref
      .watch(medicineRepository)
      .getMedicineListByIdPatient(idPatient)
      .then((medicineListString) async {
    for (var item in medicineListString) {
      var medicine =
          await ref.watch(medicineRepository).getMedicineByIdMedicine(item);
      medicineList.add(medicine);
    }
  });
  return medicineList;
});

final getAllMedicinesFutureProvider =
    FutureProvider.autoDispose<List<Medicine>>((ref) async {
  return ref.watch(medicineRepository).getAllMedicines();
});
