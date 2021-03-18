import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../models/medicine_model.dart';
import '../providers_access/providers.dart';

final getMedicineListStringByIdPatientIdFutureProvider = FutureProvider
    .autoDispose
    .family<List<Medicine>, String>((ref, idPatient) async {
  List<Medicine> medicineList = [];
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
