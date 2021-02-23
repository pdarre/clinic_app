import 'package:flutter/material.dart';

import 'app_common_background.dart';

class BuildInitial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppCommonBackground(),
          Center(
            child: Text('Initiating...', style: TextStyle(fontSize: 15)),
          ),
        ],
      ),
    );
  }
}
