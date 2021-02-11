import 'package:flutter/material.dart';

class LostConnectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/ConnectionLost.png",
            fit: BoxFit.cover,
          ),
          Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.blueGrey[300],
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey[100]),
          )),
        ],
      ),
    );
  }
}
