import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final streamGetChat =
    StreamProvider.autoDispose.family<QuerySnapshot, String>((ref, idPatient) {
  final idDoctor = FirebaseAuth.instance.currentUser.uid;

  return FirebaseFirestore.instance
      .collection('chat')
      .where('idDoctor', isEqualTo: idDoctor)
      .where('idPatient', isEqualTo: idPatient)
      .orderBy('time', descending: false)
      .snapshots();
});
