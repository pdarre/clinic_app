import 'package:clinic_app/models/appointments_model.dart';
import 'package:flutter/material.dart';

class BuildLoaded extends StatelessWidget {
  final Appointment _appointment;
  const BuildLoaded(this._appointment);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(_appointment.idPatient),
    );
  }
}
