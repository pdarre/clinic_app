import 'package:clinic_app/models/medicine_model.dart';
import 'package:clinic_app/providers.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

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

final medicinesSelectedFutureProvider =
    FutureProvider<List<MultiSelectItem<dynamic>>>((ref) {
  return ref.watch(medicineRepository).medicinesSelectedItemsList();
});
