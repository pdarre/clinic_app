import 'package:animate_do/animate_do.dart';
import 'package:clinic_app/models/beds_model.dart';
import 'package:clinic_app/models/rooms_model.dart';
import 'package:clinic_app/pages/common_states_widgets/app_common_background.dart';
import 'package:clinic_app/pages/common_states_widgets/build_error.dart';
import 'package:clinic_app/pages/common_states_widgets/build_loading.dart';
import 'package:clinic_app/pages/common_states_widgets/common_app_bar.dart';
import 'package:clinic_app/services/bed_services.dart';
import 'package:clinic_app/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoomDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Room room = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: CommonAppBar(room.idRoom),
      body: Stack(
        children: [
          AppCommonBackground(),
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
                        'Ocupied: ${room.occupancy}',
                        style: TextStyle(
                            color: Colors.blueGrey[700], fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemExtent: 80,
                    physics: BouncingScrollPhysics(),
                    itemCount: room.beds.length,
                    itemBuilder: (context, index) {
                      return BedTile(room.beds[index]);
                    },
                  ),
                ),
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
  BedTile(this.idBed);

  @override
  Widget build(BuildContext context, watch) {
    final bedFutureProvider = watch(getBedByIdBedFutureProvider(idBed));

    return bedFutureProvider.when(
      loading: () => BuildLoading(),
      error: (error, stack) => BuildError(error),
      data: (bed) => BedCard(bed),
    );
  }
}

class BedCard extends StatelessWidget {
  final Bed bed;
  const BedCard(this.bed);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.blueGrey[12],
      elevation: 1,
      child: ListTile(
        onTap: () {
          if (!bed.available) {
            Navigator.pushNamed(context, '/patient-detail-page',
                arguments: bed.idPatient);
          }
        },
        title: (bed.available)
            ? Text(
                bed.idBed,
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )
            : Text(bed.idBed, style: TextStyle(color: Colors.red)),
        subtitle: (bed.available)
            ? Text(
                'Available',
                style: TextStyle(color: Colors.green, fontSize: 11),
              )
            : Consumer(
                builder: (_, watch, __) {
                  var myUserFuture =
                      watch(getUserByIdFutureProvider(bed.idPatient));
                  myUserFuture.when(
                    loading: () => CircularProgressIndicator(),
                    error: (error, stack) => Text('Ups..'),
                    data: (myUser) =>
                        Text('${myUser.firstName} ${myUser.lastName}'),
                  );
                  return Container();
                },
              ),
        trailing: Container(
          width: 80,
          child: Row(
            children: [
              Image.asset('assets/images/hospital_bed1.jpeg'),
              (bed.available) ? Text('') : Icon(Icons.chevron_right_outlined),
            ],
          ),
        ),
      ),
    );
  }
}
