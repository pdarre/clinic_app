import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class MyUser {
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

  MyUser({
    @required this.userId,
    @required this.phone,
    @required this.email,
    @required this.gender,
    @required this.lastName,
    @required this.firstName,
    @required this.documentId,
    @required this.photo,
    @required this.userType,
    @required this.height,
    @required this.weight,
    @required this.bloodType,
    @required this.birthday,
    @required this.specialty,
    @required this.location,
  })  : assert(userId != null),
        assert(phone != null),
        assert(email != null),
        assert(gender != null),
        assert(lastName != null),
        assert(firstName != null),
        assert(documentId != null),
        assert(photo != null),
        assert(userType != null),
        assert(height != null),
        assert(weight != null),
        assert(bloodType != null),
        assert(birthday != null),
        assert(specialty != null),
        assert(location != null);

  factory MyUser.fromRawJson(String str) => MyUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyUser.fromJson(Map<String, dynamic> json) => MyUser(
      userId: json['userId'],
      phone: json['phone'],
      email: json['email'],
      gender: json['gender'],
      lastName: json['lastName'],
      firstName: json['firstName'],
      documentId: json['documentId'],
      photo: json['photo'],
      userType: json['userType'],
      height: json['height'] ?? '',
      weight: json['weight'] ?? '',
      bloodType: json['bloodType'] ?? '',
      birthday: json['birthday'] ?? Timestamp.fromDate(DateTime.now()),
      specialty: json['specialty'] ?? '',
      location: json['address']);

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'phone': phone,
        'email': email,
        'gender': gender,
        'lastName': lastName,
        'firstName': firstName,
        'documentId': documentId,
        'photo': photo,
        'userType': userType,
        'height': height,
        'weight': weight,
        'bloodType': bloodType,
        'birthday': birthday.toString(),
        'specialty': specialty,
        'address': location,
      };
}
