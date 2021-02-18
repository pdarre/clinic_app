import 'package:clinic_app/models/beds_model.dart';
import 'package:clinic_app/models/rooms_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class RoomRepositoryInterfase {
  Future<Room> getRoomByIdRoom(String idRoom);

  Future<List<Room>> getAllRooms();

  Future<Bed> getRoomByIdPatient(String idPatient);
}

class RoomRepository implements RoomRepositoryInterfase {
  final db = FirebaseFirestore.instance;

  @override
  Future<List<Room>> getAllRooms() async {
    try {
      QuerySnapshot query = await db
          .collection('rooms')
          .orderBy('roomType')
          .orderBy('idRoom', descending: false)
          .get();
      return query.docs.map((item) => Room.fromJson(item.data())).toList();
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<Bed> getRoomByIdPatient(String idPatient) async {
    try {
      QuerySnapshot query = await db
          .collection('beds')
          .where('idPatient', isEqualTo: idPatient)
          .get();

      return query.docs.map((e) => Bed.fromJson(e.data())).first;
    } on FirebaseException catch (fireException) {
      throw Exception(fireException.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Room> getRoomByIdRoom(String idRoom) {
    // TODO: implement getRoomByIdRoom
    throw UnimplementedError();
  }
}
