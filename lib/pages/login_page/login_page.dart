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
                  if (state is AuthInitial) {
                    return LoginBody();
                  } else if (state is AuthLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is AuthLoaded) {
                    return LoginBody();
                  } else if (state is AuthError) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  return null;
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

class LoginBody extends StatelessWidget {
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
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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

Future<void> myLogin(
    BuildContext context, String email, String password) async {
  await context.read(authProvider).signInWithEmailAndPassword(email, password);
}
