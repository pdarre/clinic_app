import 'package:clinic_app/models/medicine_model.dart';
import 'package:clinic_app/pages/common_states_widgets/app_common_background.dart';
import 'package:clinic_app/pages/common_states_widgets/build_error.dart';
import 'package:clinic_app/pages/common_states_widgets/build_loading.dart';
import 'package:clinic_app/pages/common_states_widgets/common_app_bar.dart';
import 'package:clinic_app/services/medicine_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MedicinesListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar('Medicines'),
      body: Stack(
        children: [
          const AppCommonBackground(),
          const MedicinesListBody(),
        ],
      ),
    );
  }
}

class MedicinesListBody extends ConsumerWidget {
  const MedicinesListBody();

  @override
  Widget build(BuildContext context, watch) {
    var allMedicinesList = watch(getAllMedicinesFutureProvider);
    return allMedicinesList.when(
      loading: () => const BuildLoading(),
      error: (error, stack) => BuildError(message: error),
      data: (list) => BuildMedicineList(medicineList: list),
    );
  }
}

class BuildMedicineList extends StatelessWidget {
  final List<Medicine> medicineList;

  const BuildMedicineList({
    this.medicineList,
  }) : assert(medicineList != null);

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
