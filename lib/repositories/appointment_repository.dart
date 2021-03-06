import 'package:clinic_app/models/appointments_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AppointmentRepositoryInterfase {
  Stream<QuerySnapshot> getAppointments(String idDoctor);
  Future<Appointment> getAppointmentById(String idAppointment);
  Future<List<Appointment>> getAppointmentsByIdDoctorAndDate(
      String idDoctor, DateTime date);
  Future<List<Appointment>> getAllAppointmentsByIdUsuario(String idPatient);
  Future<List<Appointment>> getAppointmentsByIdDoctor(String idDoctor);
  Future<Map<DateTime, List<Appointment>>> getEvents(String idDoctor);
  Future<void> updateAppointment(Appointment appointment);
  Future<void> addAppointment(Appointment appointment);
}

class AppointmentRepository implements AppointmentRepositoryInterfase {
  final _db = FirebaseFirestore.instance;

  @override
  Stream<QuerySnapshot> getAppointments(String idDoctor) {
    return FirebaseFirestore.instance
        .collection('appointments')
        .where('idDoctor', isEqualTo: idDoctor)
        .where('date',
            isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime.now()))
        .orderBy('date', descending: false)
        .snapshots();
  }

  @override
  Future<List<Appointment>> getAppointmentsByIdDoctorAndDate(
      String idDoctor, DateTime date) async {
    try {
      QuerySnapshot query = await _db
          .collection('appointments')
          .where('idDoctor', isEqualTo: idDoctor)
          .where('date', isEqualTo: Timestamp.fromDate(date))
          .get();
      return query.docs
          .map((item) => Appointment.fromJson(item.data()))
          .toList();
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<List<Appointment>> getAllAppointmentsByIdUsuario(
      String idPatient) async {
    try {
      QuerySnapshot query = await _db
          .collection('appointments')
          .where('idPatient', isEqualTo: idPatient)
          .orderBy('date', descending: true)
          .get();
      return query.docs
          .map((item) => Appointment.fromJson(item.data()))
          .toList();
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<List<Appointment>> getAppointmentsByIdDoctor(String idDoctor) async {
    try {
      QuerySnapshot query = await _db
          .collection('appointments')
          .where('idDoctor', isEqualTo: idDoctor)
          .orderBy('date', descending: false)
          .get();
      return query.docs
          .map((item) => Appointment.fromJson(item.data()))
          .toList();
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<Map<DateTime, List<Appointment>>> getEvents(String idDoctor) async {
    var map = <DateTime, List<Appointment>>{};
    try {
      var list = await getAppointmentsByIdDoctor(idDoctor);

      for (var item in list) {
        var tempDate = DateTime(item.date.year, item.date.month, item.date.day);
        var existe = map.containsKey(tempDate);
        if (map.isEmpty || !existe) {
          var tempList = <Appointment>[];
          tempList.add(item);
          map[tempDate] = tempList;
        } else if (map.containsKey(tempDate)) {
          var temp = map[tempDate];
          temp.add(item);
          map[tempDate] = temp;
        }
      }
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    } catch (error) {
      throw Exception(error);
    }
    return map;
  }

  @override
  Future<Appointment> getAppointmentById(String idAppointment) async {
    try {
      QuerySnapshot query = await _db
          .collection('appointments')
          .where('idAppointment', isEqualTo: idAppointment)
          .get();
      return query.docs.map((item) => Appointment.fromJson(item.data())).first;
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> updateAppointment(Appointment appointment) async {
    var appointments = FirebaseFirestore.instance.collection('appointments');
    try {
      await appointments
          .doc('${appointment.idDocument}')
          .update(appointment.toJson());
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> addAppointment(Appointment appoinment) async {
    var appointments = FirebaseFirestore.instance.collection('appointments');
    try {
      return await appointments.add(appoinment.toJson());
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    } catch (error) {
      throw Exception(error);
    }
  }
}
