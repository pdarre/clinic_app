import 'dart:convert';

import 'package:meta/meta.dart';

class Chat {
  String idDoctor;
  String idPatient;
  String message;
  DateTime time;
  String sender;

  Chat(
      {@required this.idDoctor,
      @required this.idPatient,
      @required this.message,
      @required this.time,
      this.sender})
      : assert(idDoctor != null),
        assert(idPatient != null),
        assert(message != null),
        assert(sender != null),
        assert(time != null);

  factory Chat.fromRawJson(String str) => Chat.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        idDoctor: json['idDoctor'],
        idPatient: json['idPatient'],
        message: json['message'],
        time: json['time'].toDate(),
        sender: json['sender'],
      );

  Map<String, dynamic> toJson() => {
        'idDoctor': idDoctor,
        'idPatient': idPatient,
        'message': message,
        'time': time,
        'sender': sender
      };
}
