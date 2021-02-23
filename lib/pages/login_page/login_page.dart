import 'dart:ui';
import 'package:clinic_app/core/common_states_widgets/build_error.dart';
import 'package:clinic_app/core/common_states_widgets/build_loading.dart';
import 'package:clinic_app/providers/auth_provider/auth_states.dart';
import 'package:clinic_app/providers/providers_access/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends StatelessWidget {
  final bool isVisible = false;

  const LoginPage();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
      ),
      child: Scaffold(
        body: Consumer(
          builder: (context, watch, child) {
            final state = watch(authProvider.state);
            if (state is AuthError) {
              return BuildError(message: state.message);
            } else if (state is AuthLoading) {
              return BuildLoading();
            } else if (state is AuthLoaded) {
              return LoginBody();
            } else {
              return LoginBody();
            }
          },
        ),
      ),
    );
  }
}

class LoginBody extends StatelessWidget {
  const LoginBody();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LoginBackground(),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoginHeader(),
              RaisedButton(
                child: Text('Kevin SignIn'),
                onPressed: () {
                  myLogin(context, 'kevindawson@mail.com', '123456');
                },
              ),
              SizedBox(height: 20),
              RaisedButton(
                child: Text('Mota SignIn'),
                onPressed: () {
                  myLogin(context, 'waltergargano@mail.com', '123456');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LoginBackground extends StatelessWidget {
  const LoginBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: -200,
          bottom: -200,
          child: Image.asset(
            'assets/images/logo.png',
            color: Colors.black12,
            height: 500,
          ),
        ),
        Positioned(
          right: -200,
          top: -200,
          child: Image.asset(
            'assets/images/logo.png',
            color: Colors.black12,
            height: 500,
          ),
        ),
      ],
    );
  }
}

class LoginHeader extends StatelessWidget {
  const LoginHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Clinic App',
            style: TextStyle(
              fontSize: 40,
              color: Colors.blueGrey[700],
            ),
          ),
          Container(
            height: 200,
            child: Image.asset('assets/images/logo.png'),
          ),
          SizedBox(height: 50)
        ],
      ),
    );
  }
}

Future<void> myLogin(
    BuildContext context, String email, String password) async {
  await context.read(authProvider).signInWithEmailAndPassword(email, password);
}
