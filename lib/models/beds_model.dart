import 'dart:convert';

class Bed {
  bool available;
  String idBed;
  String idRoom;
  String idPatient;

  Bed({this.available, this.idBed, this.idPatient, this.idRoom});

  factory Bed.fromRawJson(String str) => Bed.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Bed.fromJson(Map<String, dynamic> json) => Bed(
        available: json["available"],
        idBed: json['idBed'],
        idRoom: json['idRoom'],
        idPatient: json['idPatient'],
      );

  Map<String, dynamic> toJson() => {
        "available": available,
        "idBed": idBed,
        "idRoom": idRoom,
        "idPatient": idPatient,
      };
}
