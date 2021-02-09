import 'package:clinic_app/models/users_model.dart';
import 'package:clinic_app/pages/common_states_widgets/common_app_bar.dart';
import 'package:clinic_app/pages/lost_connection_page/lost_connection_page.dart';
import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:flutter/material.dart';
import 'patient_detail_widgets/patient_detail_Header.dart';
import 'patient_detail_widgets/patient_detail_assigned_medicines.dart';
import 'patient_detail_widgets/patient_detail_basic_data.dart';
import 'patient_detail_widgets/patient_detail_contact_options.dart';

class PatientDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MyUser patient = ModalRoute.of(context).settings.arguments;

    return ConnectivityBuilder(
      builder: (context, isConnected, status) {
        if (isConnected != null && isConnected) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: CommonAppBar(''),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: _PatientDetailBody(patient),
            ),
          );
        } else {
          return ConnectionLostPage();
        }
      },
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
