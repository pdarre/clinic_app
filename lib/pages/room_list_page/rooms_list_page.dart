import 'package:clinic_app/models/rooms_model.dart';
import 'package:clinic_app/services/room_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RoomsListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var roomList = watch(getAllRoomsFutureProvider);

    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.blueGrey),
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.chevronCircleLeft,
                size: 25, color: Colors.blueGrey[500]),
            onPressed: () => Navigator.of(context).pop()),
        title: Text(
          'Rooms',
          style: TextStyle(color: Colors.blueGrey[700]),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            left: -20,
            bottom: 50,
            child: Container(
              transform: new Matrix4.rotationZ(0.174533),
              child: Image.asset(
                'assets/images/floor_plan.png',
                color: Colors.black12,
                height: 350,
              ),
            ),
          ),
          Positioned(
            right: -100,
            top: -100,
            child: Image.asset(
              'assets/images/logo.png',
              color: Colors.black12,
              height: 300,
            ),
          ),
          // TODO add connectivity check
          roomList.when(
            loading: () => Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Ops..')),
            data: (list) => BuildRoomListBody(list),
          )
        ],
      ),
    );
  }
}

class BuildRoomListBody extends StatelessWidget {
  final List<Room> roomList;
  const BuildRoomListBody(this.roomList);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: roomList.length,
        itemBuilder: (context, index) {
          return _RoomTile(room: roomList[index]);
        },
      ),
    );
  }
}

class _RoomTile extends StatelessWidget {
  const _RoomTile({
    Key key,
    @required this.room,
  }) : super(key: key);

  final Room room;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, '/room-detail', arguments: room);
        },
        leading: (room.roomType == 'Single')
            ? Image.asset('assets/images/room_x1.jpg')
            : Image.asset('assets/images/room_x4.jpg'),
        title: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            room.idRoom,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              room.location,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(height: 20),
            (room.bedCount == room.occupancy)
                ? Text(
                    '${room.occupancy}/${room.bedCount}',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  )
                : Text(
                    '${room.occupancy}/${room.bedCount}',
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
            Divider(),
          ],
        ),
        trailing: Icon(Icons.chevron_right_outlined),
      ),
    );
  }
}
