import 'package:clinic_app/models/medicine_model.dart';
import 'package:clinic_app/services/medicine_services.dart';
import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MedicinesListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.blueGrey),
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.chevronCircleLeft,
                size: 25, color: Colors.blueGrey[500]),
            onPressed: () => Navigator.of(context).pop()),
        title: Text(
          'Available medicines',
          style: TextStyle(color: Colors.blueGrey[700]),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: ConnectivityBuilder(
        builder: (context, isConnected, status) {
          if (isConnected != null && isConnected) {
            return Stack(
              children: [
                Positioned(
                  left: -200,
                  bottom: -200,
                  child: Image.asset(
                    'assets/images/logo.png',
                    color: Colors.black12,
                    height: 500,
                  ),
                ),
                Positioned(
                  right: -200,
                  top: -200,
                  child: Image.asset(
                    'assets/images/logo.png',
                    color: Colors.black12,
                    height: 500,
                  ),
                ),
                MedicinesListBody(),
              ],
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Check your internet connection'),
                  SizedBox(height: 40),
                  CircularProgressIndicator(strokeWidth: 1),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class MedicinesListBody extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    var allMedicinesList = watch(getAllMedicinesFutureProvider);
    return allMedicinesList.when(
      loading: () => Center(child: const CircularProgressIndicator()),
      error: (error, stack) => const Text('Oops'),
      data: (list) => BuildMedicineList(list),
    );
  }
}

class BuildMedicineList extends StatelessWidget {
  final List<Medicine> medicineList;
  const BuildMedicineList(this.medicineList);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListView.builder(
        itemCount: medicineList.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: (medicineList[index].imageUrl != null)
                ? Image.asset('assets/images/pill_bottle.png')
                : Image.asset('assets/images/medicine_placeholder.png'),
            title: Text(
              '${medicineList[index].name}',
              style: TextStyle(
                  fontStyle: FontStyle.italic, fontWeight: FontWeight.w700),
            ),
            subtitle: Text(
              '${medicineList[index].indications}',
              style: TextStyle(
                  fontStyle: FontStyle.italic, fontWeight: FontWeight.w700),
            ),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).pushNamed('/medicine-detail-page',
                  arguments: medicineList[index]);
            },
          );
        },
      ),
    );
  }
}
