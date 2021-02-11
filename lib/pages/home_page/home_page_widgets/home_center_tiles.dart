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
                  const _TileCard(
                      title: 'My patients',
                      subtitle: '',
                      imageName: 'patient.png',
                      link: '/full-patients-list-page'),
                  const _TileCard(
                      title: 'Medicines',
                      subtitle: '',
                      imageName: 'medicine.png',
                      link: '/medicines-list-page'),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const _TileCard(
                      title: 'Rooms',
                      subtitle: '',
                      imageName: 'hospital_room_2.png',
                      link: '/rooms-list-page'),
                  const _TileCard(
                      title: 'Schedule',
                      subtitle: '',
                      imageName: 'agenda.png',
                      link: '/schedule-page'),
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

class _TileCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageName;
  final String link;

  const _TileCard({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.imageName,
    @required this.link,
  })  : assert(title != null),
        assert(subtitle != null),
        assert(imageName != null),
        assert(link != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
