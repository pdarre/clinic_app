import 'package:clinic_app/models/beds_model.dart';
import 'package:clinic_app/models/users_model.dart';
import 'package:clinic_app/providers/services/bed_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientAssignedRoom extends StatelessWidget {
  final MyUser patient;

  PatientAssignedRoom({this.patient});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, top: 20),
          alignment: Alignment.bottomLeft,
          child: const Text(
            'ASSIGNED ROOM',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              letterSpacing: 3,
              color: Colors.blueGrey,
            ),
          ),
        ),
        Consumer(
          builder: (context, watch, child) {
            final getBedByPatientId =
                watch(getBedByIdPatientFutureProvider(patient.userId));
            return getBedByPatientId.when(
              loading: () => Center(child: CircularProgressIndicator()),
              error: (error, stack) => AssignedRoomError(error.toString()),
              data: (data) => BuildRoomAndBedCard(data),
            );
          },
        ),
      ],
    );
  }
}

class AssignedRoomError extends StatelessWidget {
  final String error;

  const AssignedRoomError(this.error);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('No assigned room'),
        Text('$error'),
      ],
    );
  }
}

class BuildRoomAndBedCard extends StatelessWidget {
  final Bed bed;
  const BuildRoomAndBedCard(this.bed);

  @override
  Widget build(BuildContext context) {
    return bed != null
        ? Container(
            width: 300,
            height: 150,
            child: ListTile(
              title: Text('${bed.idRoom}'),
              subtitle: Text('${bed.idBed}'),
            ),
          )
        : Container(
            padding: EdgeInsets.all(20),
            child: const Text('No room assigned'),
          );
  }
}
