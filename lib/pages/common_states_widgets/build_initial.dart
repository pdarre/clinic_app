import 'package:clinic_app/pages/common_states_widgets/app_common_background.dart';
import 'package:flutter/material.dart';

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
