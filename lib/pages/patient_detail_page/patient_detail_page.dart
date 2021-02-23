import 'package:clinic_app/core/common_states_widgets/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:clinic_app/models/users_model.dart';
import 'package:clinic_app/pages/patient_detail_page/patient_detail_widgets/patient_detail_assigned_room.dart';
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
      appBar: const CommonAppBar(''),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: _PatientDetailBody(patient: patient),
      ),
    );
  }
}

class _PatientDetailBody extends StatelessWidget {
  final MyUser patient;

  const _PatientDetailBody({Key key, this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        PatientHeader(patient: patient),
        SizedBox(height: 20),
        ContactOptions(patient: patient),
        SizedBox(height: 20),
        PatientBasicData(patient: patient),
        PatientAsignedMedicines(patient: patient),
        SizedBox(height: 20),
        PatientAssignedRoom(patient: patient),
      ],
    );
  }
}
