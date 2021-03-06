import 'dart:convert';

import 'package:meta/meta.dart';

class Bed {
  bool available;
  String idBed;
  String idRoom;
  String idPatient;

  Bed({
    @required this.available,
    @required this.idBed,
    @required this.idPatient,
    @required this.idRoom,
  })  : assert(available != null),
        assert(idBed != null),
        assert(idPatient != null),
        assert(idRoom != null);

  factory Bed.fromRawJson(String str) => Bed.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Bed.fromJson(Map<String, dynamic> json) => Bed(
        available: json['available'],
        idBed: json['idBed'],
        idRoom: json['idRoom'],
        idPatient: json['idPatient'],
      );

  Map<String, dynamic> toJson() => {
        'available': available,
        'idBed': idBed,
        'idRoom': idRoom,
        'idPatient': idPatient,
      };
}
