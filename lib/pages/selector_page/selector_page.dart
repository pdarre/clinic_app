import 'package:clinic_app/pages/home_page/home_page.dart';
import 'package:clinic_app/pages/login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SelectorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (FirebaseAuth.instance.currentUser != null)
        ? HomePage()
        : LoginPage();
  }
}
