import 'package:clinic_app/models/users_model.dart';
import 'package:clinic_app/pages/home_page/home_page_widgets/home_appointments.dart';
import 'package:clinic_app/pages/home_page/home_page_widgets/home_center_tiles.dart';
import 'package:clinic_app/pages/home_page/home_page_widgets/home_doctor_greeting.dart';
import 'package:clinic_app/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomeBodyPage extends ConsumerWidget {
  final MyUser myUser;
  HomeBodyPage({this.myUser});
  @override
  Widget build(BuildContext context, watch) {
    return LiquidPullToRefresh(
      showChildOpacityTransition: false,
      borderWidth: 1.0,
      springAnimationDurationInMilliseconds: 500,
      animSpeedFactor: 1.5,
      height: 80,
      color: Colors.blueGrey,
      onRefresh: () async {
        await context.read(authProvider).findCurrentMyUser();
      },
      child: SingleChildScrollView(
        // physics: BouncingScrollPhysics(),
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
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
            // _AppointmentsList(),
            HomeAppointments(
              doctor: myUser,
            ),
          ],
        ),
      ),
    );
  }
}
