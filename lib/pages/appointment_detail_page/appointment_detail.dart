import 'package:clinic_app/models/appointments_model.dart';
import 'package:clinic_app/models/medicine_model.dart';
import 'package:clinic_app/providers.dart';
import 'package:clinic_app/services/appointment_services.dart';
import 'package:clinic_app/services/medicine_services.dart';
import 'package:clinic_app/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'dart:ui';
import 'package:date_format/date_format.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AppointmentDetail extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final String appointmentId = ModalRoute.of(context).settings.arguments;
    final getAppointment =
        watch(getAppointmentByIdFutureProvider(appointmentId));
    return Scaffold(
        body: getAppointment.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Upss..')),
      data: (appointment) => BuildAppointmentPage(appointment),
    ));
  }
}

class BuildAppointmentPage extends StatelessWidget {
  final Appointment appointment;
  const BuildAppointmentPage(this.appointment);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppointmentDetailHeader(appointment),
        AppointmentDetailBody(appointment),
      ],
    );
  }
}

class AppointmentDetailHeader extends ConsumerWidget {
  final Appointment appointment;
  const AppointmentDetailHeader(this.appointment);

  @override
  Widget build(BuildContext context, watch) {
    final getUserById = watch(getUserByIdFutureProvider(appointment.idPatient));

    return getUserById.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Upss..')),
      data: (myUser) => Header(myUser, appointment),
    );
  }
}

class Header extends StatelessWidget {
  final myUser;
  final appointment;

  const Header(this.myUser, this.appointment);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
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
        Container(
          margin: EdgeInsets.only(top: 70),
          height: 130,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Card(
            elevation: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          '${myUser.firstName} ${myUser.lastName}',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        child: Text(
                          'CI: ${myUser.documentId}',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        child: Text(
                          '${myUser.email}',
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
                      child: CircleAvatar(
                        maxRadius: 42,
                        backgroundColor: Colors.blueGrey,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(myUser.photo),
                          maxRadius: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Consumer(
          builder: (_, watch, __) {
            watch(appointmentsProvider.state);
            return appointment.completed
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
          },
        ),
      ],
    );
  }
}

class AppointmentDetailBody extends ConsumerWidget {
  final Appointment appointment;
  AppointmentDetailBody(this.appointment);

  final TextEditingController _treatmentCtrl = TextEditingController();
  final TextEditingController _notesCtrl = TextEditingController();

  @override
  Widget build(BuildContext context, watch) {
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
                                    Center(child: Text('Upss..')),
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
                      child: appointment.completed
                          ? Container()
                          : ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blueGrey[500]),
                                elevation: MaterialStateProperty.all(1),
                              ),
                              child: Text('End Consultation'),
                              onPressed: () {
                                appointment.treatment = _treatmentCtrl.text;
                                appointment.obs = _notesCtrl.text;
                                appointment.completed = true;
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Alert(appointment);
                                  },
                                );
                              },
                            ),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          appointment.completed = false;
                          context
                              .read(appointmentsProvider)
                              .updateAppointment(appointment);
                        },
                        child: Text('Retore'),
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
        FlatButton(
          child: Text("Cancel"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
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
              child: _MedicinesAsignedList(appointment: appointment),
            ),
    );
  }
}

class _MedicinesAsignedList extends StatelessWidget {
  final Appointment appointment;
  const _MedicinesAsignedList({Key key, this.appointment}) : super(key: key);

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
