import 'package:flutter/material.dart';
import 'package:clinic_app/models/users_model.dart';
import 'package:clinic_app/core/helpers/date_helper.dart';

class PatientBasicData extends StatelessWidget {
  final MyUser patient;
  PatientBasicData({this.patient});

  final DateHelper dh = DateHelper();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(
              '${dh.getAge(patient.birthday)}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.blueGrey[700]),
            ),
            Text(
              'Age',
              style: TextStyle(
                fontSize: 12,
                color: Colors.blueGrey[200],
              ),
            ),
          ],
        ),
        Container(height: 50, child: VerticalDivider(color: Colors.blueGrey)),
        Column(
          children: [
            Text(
              '${patient.height}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.blueGrey[700]),
            ),
            Text(
              'height',
              style: TextStyle(
                fontSize: 12,
                color: Colors.blueGrey[200],
              ),
            ),
          ],
        ),
        Container(height: 50, child: VerticalDivider(color: Colors.blueGrey)),
        Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${patient.bloodType.substring(0, 2)}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: Colors.blueGrey[700]),
                ),
                Text(
                  '${patient.bloodType.substring(2)}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 7,
                      color: Colors.blueGrey[500]),
                ),
              ],
            ),
            Text(
              'Blood type',
              style: TextStyle(
                fontSize: 12,
                color: Colors.blueGrey[200],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
