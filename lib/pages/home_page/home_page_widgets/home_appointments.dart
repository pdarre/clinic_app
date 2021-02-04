import 'package:clinic_app/models/appointments_model.dart';
import 'package:clinic_app/models/users_model.dart';
import 'package:clinic_app/pages/home_page/home_page_widgets/home_appointment_card.dart';
import 'package:clinic_app/providers.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/all.dart';

class HomeAppointments extends ConsumerWidget {
  final MyUser doctor;
  const HomeAppointments({this.doctor});
  @override
  Widget build(BuildContext context, watch) {
    final appointmentsList = watch(appointmentsStream.stream);
    return Container(
      height: 200,
      margin: EdgeInsets.all(10),
      child: StreamBuilder<QuerySnapshot>(
        stream: appointmentsList,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              strokeWidth: 1,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey),
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Something went wrong..'));
          } else if (snapshot.hasData && snapshot.data.size == 0) {
            return Center(child: Text('No appointments to show.'));
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              var appointment =
                  Appointment.fromJson(snapshot.data.docs[index].data());
              if (doctor?.userId != null) {
                if (appointment.idDoctor == doctor.userId) {
                  return HomeAppointmentCard(appointment: appointment);
                }
                return Center(child: Text(''));
              }
              return Center(child: CircularProgressIndicator());
            },
          );
        },
      ),
    );
  }
}
