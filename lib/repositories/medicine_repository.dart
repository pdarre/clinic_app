import 'package:clinic_app/models/appointments_model.dart';
import 'package:clinic_app/models/medicine_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

abstract class MedicineRepositoryInterfase {
  Future<Medicine> getMedicineByIdMedicine(String idMedicine);
  Future<List<Medicine>> getAllMedicines();
  Future<List<String>> getMedicineListByIdPatient(String idPatient);
}

class MedicineRepository implements MedicineRepositoryInterfase {
  final db = FirebaseFirestore.instance;

  @override
  Future<List<Medicine>> getAllMedicines() async {
    try {
      QuerySnapshot query = await db.collection('medicines').get();
      return query.docs.map((item) => Medicine.fromJson(item.data())).toList();
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<Medicine> getMedicineByIdMedicine(String idMedicine) async {
    try {
      QuerySnapshot query = await db
          .collection('medicines')
          .where('idMedicine', isEqualTo: idMedicine)
          .get();
      return query.docs.map((item) => Medicine.fromJson(item.data())).first;
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<List<String>> getMedicineListByIdPatient(String idPatient) async {
    List<String> medicinesIds = [];
    try {
      await db
          .collection('appointments')
          .where('idPatient', isEqualTo: idPatient)
          .get()
          .then((QuerySnapshot querySnapshot) => {
                querySnapshot.docs.forEach((doc) {
                  var appointment = Appointment.fromJson(doc.data());
                  if (appointment.medicines.isNotEmpty) {
                    medicinesIds = [];
                    for (var idMedicine in appointment.medicines) {
                      medicinesIds.add(idMedicine);
                    }
                  }
                })
              });
      return medicinesIds;
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<List<MultiSelectItem<dynamic>>> medicinesSelectedItemsList() async {
    List<MultiSelectItem<dynamic>> itemsList = [];
    try {
      List<Medicine> medicines = await getAllMedicines();
      for (var item in medicines) {
        itemsList.add(MultiSelectItem('${item.idMedicine}', '${item.name}'));
      }
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    } catch (error) {
      throw Exception(error);
    }
    return itemsList;
  }
}
