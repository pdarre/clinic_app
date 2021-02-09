import 'package:clinic_app/pages/appointment_detail_page/appointment_detail.dart';
import 'package:clinic_app/pages/map_page/map_page.dart';
import 'package:clinic_app/pages/medicine_detail_page/medicine_detail_page.dart';
import 'package:clinic_app/pages/medicine_list_page/medicines_list_page.dart';
import 'package:clinic_app/pages/patient_detail_page/patient_detail_page.dart';
import 'package:clinic_app/pages/patient_list_page/patient_list_page.dart';
import 'package:clinic_app/pages/room_detail_page/room_detail_page.dart';
import 'package:clinic_app/pages/room_list_page/rooms_list_page.dart';
import 'package:clinic_app/pages/schedule_page/schedule_page.dart';

class MyRoutes {
  static final routes = {
    // '/loginPage': (context) => LoginPage(),
    // '/homePage': (context) => HomePage(),
    '/patient-detail-page': (context) => PatientDetailPage(),
    '/full-patients-list-page': (context) => FullPatientsList(),
    '/medicines-list-page': (context) => MedicinesListPage(),
    '/medicine-detail-page': (context) => MedicineDetailPage(),
    '/rooms-list-page': (context) => RoomsListPage(),
    '/room-detail': (context) => RoomDetailPage(),
    '/schedule-page': (context) => SchedulePage(),
    '/appointment-detail': (context) => AppointmentDetail(),
    // // '/service-add-user': (context) => ServiceAddUser(),
    // '/video-chat-page': (context) => VideoChatPage(),
    // '/chat-page': (context) => ChatPage(),
    '/map-page': (context) => MapPage(),
  };
}
