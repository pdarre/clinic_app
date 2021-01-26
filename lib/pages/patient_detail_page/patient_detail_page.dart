import 'package:clinic_app/models/users_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'patient_detail_widgets/patient_detail_Header.dart';
import 'patient_detail_widgets/patient_detail_assigned_medicines.dart';
import 'patient_detail_widgets/patient_detail_basic_data.dart';
import 'patient_detail_widgets/patient_detail_contact_options.dart';

class PatientDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MyUser patient = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blueGrey),
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.chevronCircleLeft,
                size: 25, color: Colors.blueGrey[500]),
            onPressed: () => Navigator.of(context).pop()),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: _PatientDetailBody(patient),
      ),
    );
  }
}

class _PatientDetailBody extends StatelessWidget {
  final MyUser patient;
  _PatientDetailBody(this.patient);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        PatientHeader(patient: patient),
        SizedBox(height: 20),
        ContactOptions(patient: patient),
        SizedBox(height: 20),
        PatientBasicData(patient: patient),
        PatientAsignedMedicines(patient: patient),
        SizedBox(height: 20),
        // PatientAssignedRoom(patient: patient),
      ],
    );
  }
}
