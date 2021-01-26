import 'package:clinic_app/models/medicine_model.dart';
import 'package:clinic_app/models/users_model.dart';
import 'package:clinic_app/services/medicines_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class PatientAsignedMedicines extends ConsumerWidget {
  final MyUser patient;
  const PatientAsignedMedicines({this.patient});
  @override
  Widget build(BuildContext context, watch) {
    var list =
        watch(getMedicineListStringByIdPatientIdFutureProvider(patient.userId));

    return list.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => const Text('Oops'),
      // data: (list) => Text(list.toString()),
      data: (list) => BuildAsignedMedicinesBody(list),
    );
  }
}

class BuildAsignedMedicinesBody extends StatelessWidget {
  final List<Medicine> medicinesList;
  const BuildAsignedMedicinesBody(this.medicinesList);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        Container(
          padding: EdgeInsets.only(left: 20, top: 20),
          alignment: Alignment.bottomLeft,
          child: Text(
            'ASSIGNED MEDICINES',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              letterSpacing: 3,
              color: Colors.blueGrey,
            ),
          ),
        ),
        SizedBox(height: 10),
        BuildMedicinesAsignedToPatient(medicinesList),
      ],
    );
  }
}

class BuildMedicinesAsignedToPatient extends StatelessWidget {
  final List<Medicine> medicinesList;
  const BuildMedicinesAsignedToPatient(this.medicinesList);
  @override
  Widget build(BuildContext context) {
    return medicinesList.length > 0
        ? Container(
            height: 250,
            child: ListView.builder(
              itemCount: medicinesList.length,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return MedicineCard(medicinesList[index]);
              },
            ),
          )
        : Container(
            height: 250,
            child: Center(child: Text('No assigned medicines yet')),
          );
  }
}

class MedicineCard extends StatelessWidget {
  final Medicine medicine;
  const MedicineCard(this.medicine);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15),
      height: 230,
      width: 170,
      child: Card(
        elevation: 0,
        color: Colors.grey[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Container(
              height: 130,
              child: Image.asset(
                'assets/images/pill_bottle.png',
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: Text(
                '${medicine.name}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.blueGrey[800],
                ),
              ),
            ),
            Container(
              child: Text(
                '${medicine.presentation}',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 10,
                  color: Colors.blueGrey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
