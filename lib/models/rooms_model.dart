import 'dart:convert';
import 'package:meta/meta.dart';

class Room {
  String idRoom;
  int occupancy;
  String roomType;
  int bedCount;
  String location;
  List<String> beds = [];

  Room({
    @required this.bedCount,
    @required this.beds,
    @required this.idRoom,
    @required this.location,
    @required this.occupancy,
    @required this.roomType,
  })  : assert(bedCount != null),
        assert(beds != null),
        assert(idRoom != null),
        assert(location != null),
        assert(occupancy != null),
        assert(roomType != null);

  factory Room.fromRawJson(String str) => Room.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        idRoom: json['idRoom'],
        occupancy: json['occupancy'],
        roomType: json['roomType'],
        bedCount: json['bedCount'],
        location: json['location'],
        beds: List<String>.from(json['beds']),
      );

  Map<String, dynamic> toJson() => {
        'idRoom': idRoom,
        'occupancy': occupancy,
        'roomType': roomType,
        'beds': beds,
        'bedCount': bedCount,
        'location': location,
      };
}
