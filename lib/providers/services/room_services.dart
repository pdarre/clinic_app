import 'package:clinic_app/models/rooms_model.dart';
import 'package:clinic_app/providers/providers_access/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getAllRoomsFutureProvider =
    FutureProvider.autoDispose<List<Room>>((ref) async {
  return await ref.watch(roomRepository).getAllRooms();
});
