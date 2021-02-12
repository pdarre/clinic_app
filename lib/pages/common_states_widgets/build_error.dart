import 'package:clinic_app/pages/common_states_widgets/app_common_background.dart';
import 'package:flutter/material.dart';

class BuildError extends StatelessWidget {
  final message;

  const BuildError({this.message}) : assert(message != null);

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
                RaisedButton(
                  child: Text('Go back'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
