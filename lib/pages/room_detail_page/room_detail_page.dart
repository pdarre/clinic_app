import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/common_states_widgets/app_common_background.dart';
import '../../core/common_states_widgets/build_error.dart';
import '../../core/common_states_widgets/build_loading.dart';
import '../../core/common_states_widgets/common_app_bar.dart';
import '../../models/beds_model.dart';
import '../../models/rooms_model.dart';
import '../../providers/services/bed_services.dart';
import '../../providers/services/user_services.dart';

class RoomDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Room room = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: CommonAppBar(room.idRoom),
      body: Stack(
        children: [
          const AppCommonBackground(),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FadeInRight(
                    duration: Duration(milliseconds: 450),
                    from: 250,
                    child: Container(
                        height: 120,
                        child: (room.roomType == 'Single')
                            ? Image.asset('assets/images/room_x1-rb.png')
                            : Image.asset('assets/images/room_x4-rb.png')),
                  ),
                  Column(
                    children: [
                      Text(
                        room.location,
                        style: TextStyle(
                            color: Colors.blueGrey[700],
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Total beds: ${room.bedCount}',
                        style: TextStyle(
                            color: Colors.blueGrey[700], fontSize: 16),
                      ),
                      Text(
                        'Occupied: ${room.occupancy}',
                        style: TextStyle(
                            color: Colors.blueGrey[700], fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                    child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: room.beds.length,
                  itemBuilder: (context, index) {
                    return BedTile(idBed: room.beds[index]);
                  },
                )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BedTile extends ConsumerWidget {
  final String idBed;

  BedTile({this.idBed});

  @override
  Widget build(BuildContext context, watch) {
    final bedFutureProvider = watch(getBedByIdBedFutureProvider(idBed));

    return bedFutureProvider.when(
      loading: () => const BuildLoading(),
      error: (error, stack) => BuildError(message: error),
      data: (bed) => BedCard(bed: bed),
    );
  }
}

class BedCard extends ConsumerWidget {
  final Bed bed;

  const BedCard({this.bed}) : assert(bed != null);

  @override
  Widget build(BuildContext context, watch) {
    return Card(
      margin: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.blueGrey[12],
      elevation: 1,
      child: Column(
        children: [
          SizedBox(height: 10),
          (bed.available)
              ? Text(bed.idBed,
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.bold))
              : Text(bed.idBed, style: TextStyle(color: Colors.red)),
          SizedBox(height: 10),
          Container(
            width: 40,
            child: Image.asset(
              'assets/images/hospital_bed.jpeg',
              fit: BoxFit.fitHeight,
            ),
          ),
          SizedBox(height: 10),
          (bed.available)
              ? Text(
                  'Available',
                  style: TextStyle(color: Colors.green, fontSize: 11),
                )
              : PatientData(idPatient: bed.idPatient),
        ],
      ),
    );
  }
}

class PatientData extends ConsumerWidget {
  final String idPatient;
  const PatientData({this.idPatient});
  @override
  Widget build(BuildContext context, watch) {
    var myUserFuture = watch(getUserByIdFutureProvider(idPatient));
    return myUserFuture.when(
      loading: () => Container(
          height: 10, child: CircularProgressIndicator(strokeWidth: 0.5)),
      error: (error, stack) => Text('Ups..'),
      data: (myUser) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/patient-detail-page',
                arguments: myUser);
          },
          child: Text(
            'Occupied by ${myUser.firstName} ${myUser.lastName}',
            style: TextStyle(fontSize: 10),
          ),
        );
      },
    );
  }
}
