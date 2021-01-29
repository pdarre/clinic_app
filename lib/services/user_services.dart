import 'package:clinic_app/models/users_model.dart';
import 'package:clinic_app/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getUserByIdFutureProvider =
    FutureProvider.autoDispose.family<MyUser, String>((ref, idUser) {
  return ref.watch(authRepository).findUserById(idUser);
});
