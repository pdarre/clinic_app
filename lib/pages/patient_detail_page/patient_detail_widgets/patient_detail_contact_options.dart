import 'package:animate_do/animate_do.dart';
import 'package:clinic_app/models/users_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactOptions extends StatelessWidget {
  final MyUser patient;

  ContactOptions({this.patient});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(width: size.width * 0.1),
        FadeInLeft(
          delay: Duration(milliseconds: 0),
          duration: Duration(milliseconds: 200),
          child: GestureDetector(
            onTap: () {
              _makePhoneCall('tel:${patient.phone}');
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 3,
                    blurRadius: 9,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Image.asset(
                'assets/images/phone_2.png',
                height: 50,
              ),
            ),
          ),
        ),
        FadeInLeft(
          delay: Duration(milliseconds: 100),
          duration: Duration(milliseconds: 200),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed('/video-chat-page', arguments: patient);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    spreadRadius: 3,
                    blurRadius: 9,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Image.asset(
                'assets/images/video_2.png',
                height: 50,
              ),
            ),
          ),
        ),
        FadeInLeft(
          delay: Duration(milliseconds: 200),
          duration: Duration(milliseconds: 200),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/chat-page', arguments: patient);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(2, 6), // changes position of shadow
                  ),
                ],
              ),
              child: Image.asset(
                'assets/images/chat_2.png',
                height: 50,
              ),
            ),
          ),
        ),
        FadeInLeft(
          delay: Duration(milliseconds: 300),
          duration: Duration(milliseconds: 200),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/map-page', arguments: patient);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(2, 6), // changes position of shadow
                  ),
                ],
              ),
              child: Image.asset(
                'assets/images/location_2.png',
                height: 50,
              ),
            ),
          ),
        ),
        SizedBox(width: size.width * 0.1),
      ],
    );
  }
}

Future<void> _makePhoneCall(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
