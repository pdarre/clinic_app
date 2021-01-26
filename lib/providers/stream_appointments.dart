import 'package:cloud_firestore/cloud_firestore.dart';

class StreamAppointments {
  Stream<QuerySnapshot> getAppointments(String idDoctor) {
    var snapshots = FirebaseFirestore.instance
        .collection('appointments')
        .where('idDoctor', isEqualTo: idDoctor)
        .where('date',
            isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime.now()))
        .orderBy('date', descending: false)
        .snapshots();
    return snapshots;
  }
}
