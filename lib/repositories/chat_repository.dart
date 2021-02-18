import 'package:clinic_app/models/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ChatRepositoryInterfase {
  Future<List<Chat>> getMessagesByIdDoctorAndIdPatient(
      String idDoctor, String idPatient);

  Future<void> insertMessageByIdDoctorAndIdPatient(
      String idDoctor, String idPatient, String message, DateTime time);
}

class ChatRepository implements ChatRepositoryInterfase {
  final db = FirebaseFirestore.instance;

  @override
  Future<List<Chat>> getMessagesByIdDoctorAndIdPatient(
      String idDoctor, String idPatient) async {
    try {
      QuerySnapshot query = await db
          .collection('chat')
          .where('idDoctor', isEqualTo: idDoctor)
          .where('idPatient', isEqualTo: idPatient)
          .get();
      return query.docs.map((item) => Chat.fromJson(item.data()));
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    } catch (error) {
      throw Exception(error);
    }
  }

  Stream<QuerySnapshot> getMessages(String idDoctor, String idPatient) {
    try {
      return FirebaseFirestore.instance
          .collection('chat')
          .where('idDoctor', isEqualTo: idDoctor)
          .where('idPatient', isEqualTo: idPatient)
          .orderBy('time', descending: false)
          .snapshots();
    } on FirebaseException catch (fireException) {
      throw Exception(fireException.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> insertMessageByIdDoctorAndIdPatient(
      String idDoctor, String idPatient, String message, DateTime time) async {
    CollectionReference chat = FirebaseFirestore.instance.collection('chat');
    return chat.add({
      'idDoctor': idDoctor,
      'idPatient': idPatient,
      'message': message,
      'sender': idDoctor,
      'time': time
    });
  }
}
