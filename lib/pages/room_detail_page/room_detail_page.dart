import 'package:animate_do/animate_do.dart';
import 'package:clinic_app/models/beds_model.dart';
import 'package:clinic_app/models/rooms_model.dart';
import 'package:clinic_app/services/bed_services.dart';
import 'package:clinic_app/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RoomDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Room room = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.blueGrey),
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.chevronCircleLeft,
                size: 25, color: Colors.blueGrey[500]),
            onPressed: () => Navigator.of(context).pop()),
        title: Text(
          '${room.idRoom}',
          style: TextStyle(color: Colors.blueGrey[700]),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
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
                    physics: BouncingScrollPhysics(),
                    itemCount: room.beds.length,
                    itemBuilder: (context, index) {
                      return _BedTile(idBed: room.beds[index]);
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

class _BedTile extends ConsumerWidget {
  final String idBed;
  _BedTile({this.idBed});

  @override
  Widget build(BuildContext context, watch) {
    final bedFutureProvider = watch(getBedByIdBedFutureProvider(idBed));

    return bedFutureProvider.when(
      loading: () => Container(
          height: 10,
          width: 10,
          child: CircularProgressIndicator(strokeWidth: 0.5)),
      error: (error, stack) => Center(child: Text('${error.toString()}')),
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
        // FutureBuilder(
        //     future: context.read(userProvider).findUserByUid(bed.idPatient),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         MyUser myUser = snapshot.data;
        //         return Text('${myUser.firstName} ${myUser.lastName}');
        //       }
        //       return LinearProgressIndicator();
        //     },
        //   ),
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
