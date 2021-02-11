import 'package:clinic_app/models/users_model.dart';
import 'package:clinic_app/repositories/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}

class AuthLoaded extends AuthState {}

class AuthStateNotifierProvider extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  AuthStateNotifierProvider(this._authRepository) : super(AuthInitial());

  Future<void> signInWithEmailAndPassword(String email, String pass) async {
    try {
      state = AuthLoading();
      await _authRepository
          .signInWithEmailAndPassword(email, pass)
          .then((user) {
        state = AuthLoaded();
      });
    } on FirebaseException catch (e) {
      state = AuthError('${e.message}');
    } catch (ex) {
      state = AuthError('${ex.toString()}');
    }
  }

  // The first time (in home page) the user is found, the firebase logged user is loaded into _myUser variable
  // so its avalable throughout the entire aplication until the logout (then _myUser is set to null)
  Future<MyUser> findCurrentMyUser() async {
    return await _authRepository.findCurrentMyUser();
  }

  Future<void> logout() {
    return _authRepository.logout();
  }
}
