import 'package:clinic_app/pages/common_states_widgets/app_common_background.dart';
import 'package:flutter/material.dart';

class BuildLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppCommonBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text('Loading...', style: TextStyle(fontSize: 15)),
              // SizedBox(height: 10),
              Center(child: CircularProgressIndicator()),
            ],
          ),
        ],
      ),
    );
  }
}
