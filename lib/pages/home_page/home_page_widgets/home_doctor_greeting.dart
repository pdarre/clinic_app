import 'package:clinic_app/core/helpers/date_helper.dart';
import 'package:clinic_app/models/users_model.dart';
import 'package:flutter/material.dart';

class DoctorGreeting extends StatelessWidget {
  final MyUser myUser;

  const DoctorGreeting({
    this.myUser,
  }) : assert(myUser != null);

  @override
  Widget build(BuildContext context) {
    final today = DateHelper().getTodayDate();
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, doctor ${myUser?.lastName ?? ''}',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Have a nice day',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Text(
                  '$today',
                  style: TextStyle(
                    color: Colors.blueGrey[300],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
