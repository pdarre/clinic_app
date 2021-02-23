import 'package:clinic_app/models/users_model.dart';
import 'package:clinic_app/repositories/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_states.dart';

class AuthStateNotifierProvider extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  AuthStateNotifierProvider(this._authRepository) : super(AuthInitial());

  Future<void> signInWithEmailAndPassword(String email, String pass) async {
    try {
      state = AuthLoading();
      await _authRepository
          .signInWithEmailAndPassword(email, pass)
          .then((user) {
        state = AuthLoaded(user.user.uid);
      });
    } on FirebaseException catch (e) {
      state = AuthError('${e.message}');
    } catch (ex) {
      state = AuthError('${ex.toString()}');
    }
  }

  Future<MyUser> findCurrentMyUser() async {
    return await _authRepository.findCurrentMyUser();
  }

  Future<void> logout() {
    return _authRepository.logout();
  }
}
