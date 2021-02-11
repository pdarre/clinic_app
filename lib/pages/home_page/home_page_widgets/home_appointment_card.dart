import 'package:clinic_app/models/appointments_model.dart';
import 'package:clinic_app/models/users_model.dart';
import 'package:clinic_app/providers.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeAppointmentCard extends ConsumerWidget {
  final Appointment appointment;

  const HomeAppointmentCard({
    @required this.appointment,
  }) : assert(appointment != null);

  @override
  Widget build(BuildContext context, watch) {
    return Container(
      height: 200,
      width: 150,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('/appointment-detail',
              arguments: appointment.idAppointment);
        },
        child: Stack(
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              child: FutureBuilder<MyUser>(
                future:
                    watch(authRepository).findUserById(appointment.idPatient),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final temp = snapshot.data;
                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                maxRadius: 27,
                                backgroundColor: Colors.blueGrey[300],
                                child: CircleAvatar(
                                  maxRadius: 25,
                                  backgroundImage:
                                      NetworkImage('${snapshot.data.photo}'),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text('${temp.firstName} ${temp.lastName}',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Expanded(child: Container()),
                          SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(appointment.reason,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      TextStyle(color: Colors.blueGrey[300])),
                              SizedBox(height: 20),
                              Text(formatDate(
                                  appointment.date, [d, '-', M, '-', yyyy])),
                              Text('Hora ${formatDate(
                                appointment.date,
                                [HH, ':', nn],
                              )}'),
                            ],
                          ),
                        ],
                      ),
                    );
                  }

                  return Center(
                      child: CircularProgressIndicator(strokeWidth: 1));
                },
              ),
            ),
            (appointment.completed)
                ? Container(
                    padding: EdgeInsets.only(top: 40, left: 10),
                    child: Image.asset('assets/images/closed_stamp.png'))
                : Container()
          ],
        ),
      ),
    );
  }
}
