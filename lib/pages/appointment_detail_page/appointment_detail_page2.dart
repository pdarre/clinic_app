import 'package:clinic_app/models/appointments_model.dart';
import 'package:clinic_app/pages/common_states_widgets/build_error.dart';
import 'package:clinic_app/pages/common_states_widgets/build_initial.dart';
import 'package:clinic_app/pages/common_states_widgets/build_loading.dart';
import 'package:clinic_app/providers.dart';
import 'package:clinic_app/providers/appointment_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppointmentDetail extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final String appointmentId = ModalRoute.of(context).settings.arguments;
    context.read(appointmentsProvider).getAppointmentById(appointmentId);
    final appointmentState = watch(appointmentsProvider.state);
    if (appointmentState is AppointmentLoaded) {
      return BuildLoaded(appointment: appointmentState.appointment);
    } else if (appointmentState is AppointmentLoading) {
      return BuildLoading();
    } else if (appointmentState is AppointmentError) {
      return BuildError(appointmentState.message);
    } else {
      return BuildInitial();
    }
  }
}

class BuildLoaded extends StatelessWidget {
  const BuildLoaded({Key key, @required this.appointment})
      : assert(appointment != null),
        super(key: key);

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
