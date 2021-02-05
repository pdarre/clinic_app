import 'dart:ui';

import 'package:clinic_app/providers.dart';
import 'package:clinic_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends StatelessWidget {
  final bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
      ),
      child: Scaffold(
        body: ConnectivityBuilder(
          builder: (context, isConnected, status) {
            if (isConnected != null && isConnected) {
              return Consumer(
                builder: (context, watch, child) {
                  final state = watch(authProvider.state);
                  if (state is AuthError) {
                    return LoginError(state.message);
                  } else if (state is AuthLoading) {
                    return LoadingBody();
                  } else if (state is AuthLoaded) {
                    return LoginBody();
                  } else {
                    return LoginBody();
                  }
                },
              );
            } else {
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Check your internet connection'),
                      SizedBox(height: 20),
                      CircularProgressIndicator(strokeWidth: 1),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class LoginError extends StatelessWidget {
  final String error;
  const LoginError(this.error);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ups, something went wrong'),
            Text('$error'),
            RaisedButton(
              child: Text('Go back'),
              onPressed: () {
                return LoginBody();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LoginBody extends StatelessWidget {
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
        ],
      ),
    );
  }
}

class LoadingBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LoginBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: CircularProgressIndicator()),
            ],
          ),
        ],
      ),
    );
  }
}

Future<void> myLogin(
    BuildContext context, String email, String password) async {
  await context.read(authProvider).signInWithEmailAndPassword(email, password);
}
