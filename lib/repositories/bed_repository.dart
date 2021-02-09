import 'package:clinic_app/models/beds_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BedRepositoryInterfase {
  Future<Bed> getBedByIdRoom(String idBed);
  Future<Bed> getBedByIdBed(String idBed);
  Future<List<Bed>> getAllBeds();
  Future<List<String>> getBedByIdPatient(String idPatient);
}

class BedRepository implements BedRepositoryInterfase {
  final db = FirebaseFirestore.instance;

  @override
  Future<Bed> getBedByIdBed(String idBed) async {
    try {
      QuerySnapshot query =
          await db.collection('beds').where('idBed', isEqualTo: idBed).get();
      return query.docs.map((item) => Bed.fromJson(item.data())).first;
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<List<Bed>> getAllBeds() {
    // TODO: implement getAllBeds
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getBedByIdPatient(String idPatient) {
    // TODO: implement getBedByIdPatient
    throw UnimplementedError();
  }

  @override
  Future<Bed> getBedByIdRoom(String idBed) {
    // TODO: implement getBedByIdRoom
    throw UnimplementedError();
  }
}
