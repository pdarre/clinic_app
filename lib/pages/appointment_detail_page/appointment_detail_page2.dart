import 'package:flutter/material.dart';
import 'package:clinic_app/providers.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:clinic_app/pages/common_states_widgets/build_error.dart';
import 'package:clinic_app/pages/common_states_widgets/build_initial.dart';
import 'package:clinic_app/pages/common_states_widgets/build_loading.dart';
import 'package:clinic_app/providers/appointment_provider.dart';

import 'appointment_widgets/build_loaded.dart';

class AppointmentDetail extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final String appointmentId = ModalRoute.of(context).settings.arguments;
    context.read(appointmentsProvider).getAppointmentById(appointmentId);
    final appointment = watch(appointmentsProvider.state);
    if (appointment is AppointmentLoaded) {
      return BuildLoaded(appointment.appointment);
    } else if (appointment is AppointmentLoading) {
      return BuildLoading();
    } else if (appointment is AppointmentError) {
      return BuildError(appointment.message);
    } else {
      return BuildInitial();
    }
  }
}
