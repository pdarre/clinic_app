import 'package:flutter/material.dart';

class TileCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String imageName;

  TileCard({
    @required this.title,
    @required this.subTitle,
    @required this.imageName,
  })  : assert(title != null),
        assert(subTitle != null),
        assert(imageName != null);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 10, top: 20),
        height: 160,
        width: 160,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.center,
              children: [
                RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              subTitle,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: Colors.blueGrey[300],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10, left: 5),
              child: CircleAvatar(
                // backgroundColor: Colors.blueGrey[200],
                backgroundColor: Colors.transparent,
                maxRadius: 55,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/$imageName'),
                  minRadius: 50,
                  maxRadius: 54,
                  // backgroundColor: Colors.blueGrey[100],
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
