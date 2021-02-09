import 'package:clinic_app/models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapRepository {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<LatLng> getPatientAddress(String idPatient) async {
    try {
      QuerySnapshot query =
          await users.where('userId', isEqualTo: idPatient).get();
      MyUser myUser =
          query.docs.map((item) => MyUser.fromJson(item.data())).first;
      return LatLng(myUser.location.latitude, myUser.location.longitude);
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    } catch (error) {
      throw Exception(error);
    }
  }
}
