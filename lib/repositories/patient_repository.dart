import 'package:clinic_app/models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PatientRepositoryInterfase {
  Future<List<MyUser>> getAllPatients();
  Future<MyUser> getPatientById(String idPatient);
}

class PatientRepository implements PatientRepositoryInterfase {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Future<List<MyUser>> getAllPatients() async {
    try {
      QuerySnapshot query = await users.where('userType', isEqualTo: 'U').get();
      return query.docs.map((item) => MyUser.fromJson(item.data())).toList();
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<MyUser> getPatientById(String idPatient) async {
    try {
      QuerySnapshot query =
          await users.where('userId', isEqualTo: idPatient).get();
      return query.docs.map((item) => MyUser.fromJson(item.data())).first;
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    } catch (error) {
      throw Exception(error);
    }
  }
}
