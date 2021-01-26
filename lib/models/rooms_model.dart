import 'dart:convert';

class Room {
  String idRoom;
  int occupancy;
  String roomType;
  int bedCount;
  String location;
  List<String> beds = [];

  Room({
    this.bedCount,
    this.beds,
    this.idRoom,
    this.location,
    this.occupancy,
    this.roomType,
  });

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
