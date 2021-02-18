import 'package:clinic_app/repositories/chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatProvider {
  final ChatRepository _chatRepository;
  const ChatProvider(this._chatRepository) : assert(_chatRepository != null);

  Future<void> insertMessageByIdDoctorAndIdPatient(
      String idDoctor, String idPatient, String message, DateTime time) async {
    try {
      _chatRepository.insertMessageByIdDoctorAndIdPatient(
          idDoctor, idPatient, message, time);
    } on FirebaseException catch (fireException) {
      throw Exception(fireException.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Stream<QuerySnapshot> getMessages(String idDoctor, String idPatient) {
    return _chatRepository.getMessages(idDoctor, idPatient);
  }
}
