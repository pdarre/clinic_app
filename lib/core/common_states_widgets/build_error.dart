import 'package:flutter/material.dart';

import 'app_common_background.dart';

class BuildError extends StatelessWidget {
  final String message;

  const BuildError({this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppCommonBackground(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Something went wrong..',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                Text(message),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Go back'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
