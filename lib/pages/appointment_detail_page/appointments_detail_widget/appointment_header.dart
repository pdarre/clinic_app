import 'package:clinic_app/models/users_model.dart';
import 'package:clinic_app/providers/appointment_provider/appointments_states.dart';
import 'package:clinic_app/providers/providers_access/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppointmentHeader extends StatelessWidget {
  final MyUser patient;
  const AppointmentHeader({this.patient});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        HeaderBackground(),
        HeaderPatientDetail(patient: patient),
        HeaderStamp(),
      ],
    );
  }
}

class HeaderBackground extends StatelessWidget {
  const HeaderBackground();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 160,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Colors.blueGrey[100], Colors.blueGrey[700]]),
          ),
        ),
        Positioned(
          top: -30,
          right: -50,
          child: Image.asset(
            'assets/images/logo.png',
            color: Colors.black38,
            height: 200,
          ),
        ),
        Container(
          child: Positioned(
            top: 25,
            left: 5,
            child: IconButton(
                icon: Icon(FontAwesomeIcons.chevronCircleLeft,
                    size: 25, color: Colors.blueGrey[500]),
                onPressed: () => Navigator.of(context).pop()),
          ),
        ),
      ],
    );
  }
}

class HeaderPatientDetail extends StatelessWidget {
  final MyUser patient;
  const HeaderPatientDetail({this.patient});

  @override
  Widget build(BuildContext context) {
    final myWith = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: 70),
      height: 130,
      width: myWith * 0.9,
      child: Card(
        elevation: 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      '${patient.firstName} ${patient.lastName}',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    child: Text(
                      'CI: ${patient.documentId}',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    child: Text(
                      '${patient.email}',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/patient-detail-page',
                          arguments: patient);
                    },
                    child: Hero(
                      tag: patient.userId,
                      child: CircleAvatar(
                        maxRadius: 42,
                        backgroundColor: Colors.blueGrey,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(patient.photo),
                          maxRadius: 40,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderStamp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, watch, __) {
        final appointmentState = watch(appointmentsProvider.state);
        if (appointmentState is AppointmentLoaded) {
          return appointmentState.appointment.completed
              ? Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/closed_stamp.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container();
        } else {
          return Container();
        }
      },
    );
  }
}
