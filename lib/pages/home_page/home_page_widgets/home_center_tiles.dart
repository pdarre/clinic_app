import 'package:clinic_app/pages/home_page/home_page_widgets/home_tile_card.dart';
import 'package:flutter/material.dart';

class CenterTiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
            top: -50,
            left: 30,
            child: Image.asset(
              'assets/images/logo.png',
              color: Colors.black12,
              height: 400,
            ),
          ),
          Column(
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _tileCard(
                    context,
                    'My patients',
                    '',
                    'patient.png',
                    '/full-patients-list-page',
                  ),
                  _tileCard(
                    context,
                    'Medicines',
                    '',
                    'medicine.png',
                    '/medicines-list-page',
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _tileCard(
                    context,
                    'Rooms',
                    '',
                    'hospital_room_2.png',
                    '/rooms-list-page',
                  ),
                  _tileCard(
                    context,
                    'Schedule',
                    '',
                    'agenda.png',
                    '/schedule-page',
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _tileCard(BuildContext context, String title, String subtitle,
    String imageName, String link) {
  return InkWell(
    child: TileCard(
      title: '$title',
      subTitle: '$subtitle',
      imageName: '$imageName',
    ),
    onTap: () {
      Navigator.of(context).pushNamed('$link');
    },
  );
}
