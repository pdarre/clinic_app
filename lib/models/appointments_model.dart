import 'dart:convert';

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
    this.date,
    this.idAppointment,
    this.idBed,
    this.idDoctor,
    this.idDocument,
    this.idPatient,
    this.medicines,
    this.obs,
    this.reason,
    this.specialty,
    this.treatment,
  });

  factory Appointment.fromRawJson(String str) =>
      Appointment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
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
        "idPatient": idPatient,
        "idDoctor": idDoctor,
        "specialty": specialty,
        "date": date,
        "reason": reason,
        "completed": completed,
        "obs": obs,
        "medicines": medicines,
        "treatment": treatment,
        "idAppointment": idAppointment,
        "idDocument": idDocument,
        "idBed": idBed,
      };
}
