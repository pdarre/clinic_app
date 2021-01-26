import 'package:clinic_app/models/users_model.dart';
import 'package:flutter/material.dart';

class PatientHeader extends StatelessWidget {
  final MyUser patient;
  PatientHeader({this.patient});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: patient.userId,
          child: CircleAvatar(
            maxRadius: 55,
            backgroundColor: Colors.blueGrey[200],
            child: CircleAvatar(
              maxRadius: 52,
              backgroundImage: NetworkImage(patient.photo),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          '${patient.firstName} ${patient.lastName}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        Text('${patient.email}'),
      ],
    );
  }
}
