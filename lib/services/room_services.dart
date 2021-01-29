import 'package:clinic_app/models/rooms_model.dart';
import 'package:clinic_app/providers.dart';
import 'package:flutter_riverpod/all.dart';

final getAllRoomsFutureProvider =
    FutureProvider.autoDispose<List<Room>>((ref) async {
  return await ref.watch(roomRepository).getAllRooms();
});