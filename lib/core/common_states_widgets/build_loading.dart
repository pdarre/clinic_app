import 'package:flutter/material.dart';

import 'app_common_background.dart';

class BuildLoading extends StatelessWidget {
  const BuildLoading();

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
