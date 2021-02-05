import 'package:clinic_app/models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepositoryInterfase {
  Future<void> signInWithEmailAndPassword(String email, String pass);
  Future<MyUser> findUserById(String idUser);
  Future<MyUser> findCurrentMyUser();
  Future<void> logout();
}

class AuthRepository implements AuthRepositoryInterfase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Stream<User> get authStateChanges => FirebaseAuth.instance.authStateChanges();

  @override
  Future<void> signInWithEmailAndPassword(String email, String pass) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<MyUser> findUserById(String idUser) async {
    MyUser myUser;
    try {
      await users
          .where('userId', isEqualTo: idUser)
          .get()
          .then((QuerySnapshot querySnapshot) => {
                querySnapshot.docs.forEach((doc) {
                  myUser = MyUser.fromJson(doc.data());
                })
              });
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    } catch (error) {
      throw Exception(error);
    }
    return myUser;
  }

  @override
  Future<MyUser> findCurrentMyUser() async {
    try {
      var uid = FirebaseAuth.instance.currentUser.uid;
      return findUserById(uid);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    } catch (error) {
      throw Exception(error);
    }
  }
}
