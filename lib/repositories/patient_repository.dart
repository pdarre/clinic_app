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
    var myUsers = <MyUser>[];
    try {
      await users
          .where('userType', isEqualTo: 'U')
          .get()
          .then((QuerySnapshot querySnapshot) => {
                querySnapshot.docs.forEach((doc) {
                  myUsers.add(MyUser.fromJson(doc.data()));
                })
              });
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    } catch (error) {
      throw Exception(error);
    }
    return myUsers;
  }

  @override
  Future<MyUser> getPatientById(String idPatient) async {
    MyUser myUser;
    try {
      await users
          .where('userId', isEqualTo: idPatient)
          .get()
          .then((QuerySnapshot querySnapshot) => {
                querySnapshot.docs.forEach((doc) {
                  myUser = MyUser.fromJson(doc.data());
                })
              });
      return myUser;
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    } catch (error) {
      throw Exception(error);
    }
  }
}
