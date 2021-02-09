import 'package:flutter/material.dart';

class AppCommonBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
      ),
    );
  }
}
