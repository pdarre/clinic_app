import 'package:clinic_app/models/appointments_model.dart';
import 'package:clinic_app/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getAppointmentByIdFutureProvider =
    FutureProvider.family<Appointment, String>((ref, idAppointment) async {
  return await ref
      .watch(appointmentRepository)
      .getAppointmentById(idAppointment);
});

final getEvents = FutureProvider.autoDispose
    .family<Map<DateTime, List<Appointment>>, String>((ref, idDoctor) async {
  return ref.watch(appointmentRepository).getEvents(idDoctor);
});
