import 'dart:convert';
import 'package:meta/meta.dart';

class Appointment {
  String idAppointment;
  String specialty;
  String idDoctor;
  String idPatient;
  String reason;
  DateTime date;
  bool completed;
  String obs;
  List<String> medicines = [];
  String treatment;
  String idDocument;
  String idBed;

  Appointment({
    this.completed = false,
    @required this.date,
    @required this.idAppointment,
    @required this.idBed,
    @required this.idDoctor,
    @required this.idDocument,
    @required this.idPatient,
    @required this.medicines,
    @required this.obs,
    @required this.reason,
    @required this.specialty,
    @required this.treatment,
  })  : assert(date != null),
        assert(idAppointment != null),
        assert(idBed != null),
        assert(idDoctor != null),
        assert(idDocument != null),
        assert(idPatient != null),
        assert(medicines != null),
        assert(obs != null),
        assert(reason != null),
        assert(specialty != null),
        assert(treatment != null);

  factory Appointment.fromRawJson(String str) =>
      Appointment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        // ignore: prefer_single_quotes
        idPatient: json["idPatient"],
        idDoctor: json['idDoctor'],
        specialty: json['specialty'],
        date: json['date'].toDate(),
        reason: json['reason'],
        completed: json['completed'],
        medicines: List<String>.from(
              json['medicines'],
            ) ??
            [],
        treatment: json['treatment'] ?? '',
        obs: json['obs'] ?? '',
        idAppointment: json['idAppointment'],
        idDocument: json['idDocument'],
        idBed: json['idBed'],
      );

  Map<String, dynamic> toJson() => {
        'idPatient': idPatient,
        'idDoctor': idDoctor,
        'specialty': specialty,
        'date': date,
        'reason': reason,
        'completed': completed,
        'obs': obs,
        'medicines': medicines,
        'treatment': treatment,
        'idAppointment': idAppointment,
        'idDocument': idDocument,
        'idBed': idBed,
      };
}
