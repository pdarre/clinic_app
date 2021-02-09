import 'package:flutter/material.dart';

class ConnectionLostPage extends StatelessWidget {
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
          // Positioned(
          //   bottom: MediaQuery.of(context).size.height * 0.12,
          //   left: MediaQuery.of(context).size.width * 0.065,
          //   child: Container(
          //     decoration: BoxDecoration(
          //       boxShadow: [
          //         BoxShadow(
          //           offset: Offset(0, 5),
          //           blurRadius: 25,
          //           color: Color(0xFF59618B).withOpacity(0.17),
          //         ),
          //       ],
          //     ),
          //     child: FlatButton(
          //       color: Color(0xFF6371AA),
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(50)),
          //       onPressed: () {
          //         Navigator.of(context).pop();
          //       },
          //       child: Text(
          //         "retry".toUpperCase(),
          //         style: TextStyle(color: Colors.white),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
