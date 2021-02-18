import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clinic_app/providers.dart';
import 'package:clinic_app/pages/common_states_widgets/build_error.dart';
import 'package:clinic_app/pages/common_states_widgets/build_initial.dart';
import 'package:clinic_app/pages/common_states_widgets/build_loading.dart';
import 'package:clinic_app/providers/appointment_provider.dart';
import 'package:clinic_app/services/user_services.dart';
import 'appointments_detail_widget/appointment_detail_body.dart';
import 'appointments_detail_widget/appointment_header.dart';

class AppointmentDetail extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final appointmentState = watch(appointmentsProvider.state);
    if (appointmentState is AppointmentLoading) {
      return BuildLoading();
    } else if (appointmentState is AppointmentError) {
      String message = appointmentState.message;
      return BuildError(message: message);
    } else if (appointmentState is AppointmentLoaded) {
      return BuildLoaded(idPatient: appointmentState.appointment.idPatient);
    } else {
      return BuildInitial();
    }
  }
}

class BuildLoaded extends StatelessWidget {
  final String idPatient;

  const BuildLoaded({Key key, @required this.idPatient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppointmentDetailHeader(idPatient: idPatient),
          AppointmentDetailBody(),
        ],
      ),
    );
  }
}

class AppointmentDetailHeader extends ConsumerWidget {
  final String idPatient;

  const AppointmentDetailHeader({this.idPatient});

  @override
  Widget build(BuildContext context, watch) {
    final getPatientById = watch(getUserByIdFutureProvider(idPatient));
    return getPatientById.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => const Center(child: Text('Ups..')),
      data: (patient) => AppointmentHeader(patient: patient),
    );
  }
}
