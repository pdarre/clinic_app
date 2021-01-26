// import 'package:clinic_app/models/users_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/all.dart';

// class PatientAssignedRoom extends StatelessWidget {
//   final MyUser patient;
//   PatientAssignedRoom({this.patient});
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.only(left: 20, top: 20),
//           alignment: Alignment.bottomLeft,
//           child: Text(
//             'ASSIGNED ROOM',
//             style: TextStyle(
//               fontWeight: FontWeight.w600,
//               letterSpacing: 3,
//               color: Colors.blueGrey,
//             ),
//           ),
//         ),
//         FutureBuilder(
//           future:
//               context.read(roomsProvider).findRoomByIdPatient(patient.userId),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               if (snapshot.data != null) {
//                 Bed bed = snapshot.data;
//                 return Container(
//                   height: 150,
//                   width: MediaQuery.of(context).size.width * 0.95,
//                   child: Card(
//                     elevation: 1,
//                     color: Colors.grey[100],
//                     child: Text(bed.idRoom),
//                   ),
//                 );
//               }
//               return Center(
//                 child: Container(
//                   margin: EdgeInsets.all(10),
//                   child: Text(
//                     'No assigned room',
//                     style: TextStyle(
//                       fontSize: 10,
//                       color: Theme.of(context).accentColor,
//                     ),
//                   ),
//                 ),
//               );
//             }
//             return Center(
//               child: Container(
//                 child: CircularProgressIndicator(
//                   strokeWidth: 1,
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
