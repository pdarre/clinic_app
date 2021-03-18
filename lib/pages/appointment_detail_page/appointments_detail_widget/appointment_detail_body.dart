import 'package:clinic_app/models/appointments_model.dart';
import 'package:clinic_app/models/medicine_model.dart';
import 'package:clinic_app/providers/appointment_provider/appointments_states.dart';
import 'package:clinic_app/providers/providers_access/providers.dart';
import 'package:clinic_app/providers/services/medicine_services.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class AppointmentDetailBody extends ConsumerWidget {
  final TextEditingController _treatmentCtrl = TextEditingController();
  final TextEditingController _notesCtrl = TextEditingController();

  @override
  Widget build(BuildContext context, watch) {
    final appointmentState = watch(appointmentsProvider.state);
    Appointment appointment;
    if (appointmentState is AppointmentLoaded) {
      appointment = appointmentState.appointment;
    }

    if (appointment.completed) {
      _treatmentCtrl.text = appointment.treatment;
      _notesCtrl.text = appointment.obs;
    }

    final size = MediaQuery.of(context).size;
    return Expanded(
      child: SingleChildScrollView(
        child: Form(
          child: Container(
            width: size.width * 0.95,
            child: Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text('Appointment : '),
                    Text(
                      '${formatDate(appointment.date, [
                        d,
                        '-',
                        M,
                        '-',
                        yyyy
                      ])}  ${formatDate(appointment.date, [HH, ':', nn])}Hs',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      thickness: 1,
                      endIndent: 10,
                      indent: 10,
                    ),
                    SizedBox(height: 10),
                    Text('Reason: '),
                    Text('${appointment.reason}',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    Divider(
                      thickness: 1,
                      endIndent: 10,
                      indent: 10,
                    ),
                    SizedBox(height: 10),
                    Text('Specialty: '),
                    Text('${appointment.specialty}',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    Divider(
                      thickness: 1,
                      endIndent: 10,
                      indent: 10,
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        enabled: !appointment.completed,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 5,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: _treatmentCtrl,
                        decoration: const InputDecoration(
                          icon: Icon(FontAwesomeIcons.notesMedical),
                          hintText: 'Treatment notes',
                          labelText: 'Treatment',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        enabled: !appointment.completed,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 5,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          icon: Icon(FontAwesomeIcons.notesMedical),
                          hintText: 'Observations notes',
                          labelText: 'Notes',
                        ),
                        controller: _notesCtrl,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Consumer(
                            builder: (_, watch, __) {
                              final medicinesSelectedItems =
                                  watch(medicinesSelectedFutureProvider);
                              return medicinesSelectedItems.when(
                                loading: () =>
                                    Center(child: CircularProgressIndicator()),
                                error: (error, stack) =>
                                    Center(child: const Text('Upss..')),
                                data: (list) =>
                                    _MultiSelectDialog(appointment, list),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: Consumer(
                        builder: (_, watch, __) {
                          final myAppointment =
                              watch(appointmentsProvider.state);
                          if (myAppointment is AppointmentLoaded) {
                            print('');
                            return myAppointment.appointment.completed
                                ? Container()
                                : ElevatedButton(
                                    child: const Text('End appointment'),
                                    onPressed: () {
                                      appointment.treatment =
                                          _treatmentCtrl.text;
                                      appointment.obs = _notesCtrl.text;
                                      appointment.completed = true;
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Alert(appointment);
                                        },
                                      );
                                    },
                                  );
                          }
                          return Container();
                        },
                      ),
                    ),
                    Center(
                      child: Consumer(
                        builder: (_, watch, __) {
                          final myAppointment =
                              watch(appointmentsProvider.state);
                          if (myAppointment is AppointmentLoaded) {
                            return !myAppointment.appointment.completed
                                ? Container()
                                : ElevatedButton(
                                    child: const Text('Reset'),
                                    onPressed: () {
                                      appointment.completed = false;
                                      appointment.medicines = [];
                                      context
                                          .read(appointmentsProvider)
                                          .updateAppointment(appointment);
                                    },
                                  );
                          }
                          return Container();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Alert extends StatelessWidget {
  final Appointment appointment;

  const Alert(this.appointment);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Confirm action"),
      content: Text("Close this consult?"),
      actions: [
        ElevatedButton(
          child: Text("Cancel"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: Text("Continue"),
          onPressed: () async {
            await context
                .read(appointmentsProvider)
                .updateAppointment(appointment);

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class _MultiSelectDialog extends StatelessWidget {
  final Appointment appointment;
  final List<MultiSelectItem<dynamic>> list;

  const _MultiSelectDialog(this.appointment, this.list);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (!appointment.completed)
          ? MultiSelectDialogField(
              initialValue: [],
              items: list,
              listType: MultiSelectListType.CHIP,
              onConfirm: (values) {
                appointment.medicines.clear();
                if (values.length > 0) {
                  for (var i = 0; i < values.length; i++) {
                    appointment.medicines.add(values[i]);
                  }
                }
              },
              buttonText: Text('Add medicines...  '),
              buttonIcon: Icon(FontAwesomeIcons.plusSquare),
              confirmText: Text('Confirm'),
            )
          : Container(
              width: 200,
              height: 100,
              child: _MedicinesAssignedList(appointment: appointment),
            ),
    );
  }
}

class _MedicinesAssignedList extends StatelessWidget {
  final Appointment appointment;

  const _MedicinesAssignedList({Key key, this.appointment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: appointment.medicines.length,
      itemBuilder: (context, index) {
        return FutureBuilder(
          future: context
              .read(medicineProvider)
              .getMedicineByIdMedicine(appointment.medicines[index]),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Medicine medicine = snapshot.data;
              return Container(
                margin: EdgeInsets.all(4),
                child: Chip(
                  label: Text('${medicine.name}'),
                  backgroundColor: Colors.blueGrey[100],
                ),
              );
            }
            return Container(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(strokeWidth: 1));
          },
        );
      },
    );
  }
}
