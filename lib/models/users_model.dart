import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  MyUser({
    this.userId,
    this.phone,
    this.email,
    this.gender,
    this.lastName,
    this.firstName,
    this.documentId,
    this.photo,
    this.userType,
    this.height,
    this.weight,
    this.bloodType,
    this.birthday,
    this.specialty,
    this.location,
  });

  String userId;
  String phone;
  String email;
  String gender;
  String lastName;
  String firstName;
  String documentId;
  String photo;
  String userType;
  String height;
  String weight;
  String bloodType;
  Timestamp birthday;
  String specialty;
  GeoPoint location;

  factory MyUser.fromRawJson(String str) => MyUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyUser.fromJson(Map<String, dynamic> json) => MyUser(
      userId: json["userId"],
      phone: json["phone"],
      email: json["email"],
      gender: json["gender"],
      lastName: json["lastName"],
      firstName: json["firstName"],
      documentId: json["documentId"],
      photo: json['photo'],
      userType: json['userType'],
      height: json['height'] ?? '',
      weight: json['weight'] ?? '',
      bloodType: json['bloodType'] ?? '',
      birthday: json['birthday'] ?? Timestamp.fromDate(DateTime.now()),
      specialty: json['specialty'] ?? '',
      location: json['address']);

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "phone": phone,
        "email": email,
        "gender": gender,
        "lastName": lastName,
        "firstName": firstName,
        "documentId": documentId,
        "photo": photo,
        "userType": userType,
        "height": height,
        "weight": weight,
        "bloodType": bloodType,
        "birthday": birthday.toString(),
        "specialty": specialty,
        "address": location,
      };
}
