import 'package:clinic_app/models/users_model.dart';
import 'package:clinic_app/pages/home_page/home_page_widgets/home_appointments.dart';
import 'package:clinic_app/pages/home_page/home_page_widgets/home_center_tiles.dart';
import 'package:clinic_app/pages/home_page/home_page_widgets/home_doctor_greeting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class HomeBodyPage extends ConsumerWidget {
  final MyUser myUser;
  const HomeBodyPage({this.myUser});
  @override
  Widget build(BuildContext context, watch) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          DoctorGreeting(myUser: myUser),
          CenterTiles(),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Text(
                  'My schedule',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[300],
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          HomeAppointments(
            doctor: myUser,
          ),
        ],
      ),
    );
  }
}
