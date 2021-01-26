import 'package:animate_do/animate_do.dart';
import 'package:clinic_app/models/medicine_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MedicineDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Medicine medicine = ModalRoute.of(context).settings.arguments;
    final mySize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.blueGrey),
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.chevronCircleLeft,
                size: 25, color: Colors.blueGrey[500]),
            onPressed: () => Navigator.of(context).pop()),
        title: Text(
          '${medicine.name}',
          style: TextStyle(
              color: Colors.blueGrey[700],
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            left: -200,
            bottom: -200,
            child: Image.asset(
              'assets/images/logo.png',
              color: Colors.black12,
              height: 500,
            ),
          ),
          Positioned(
            right: -200,
            top: -200,
            child: Image.asset(
              'assets/images/logo.png',
              color: Colors.black12,
              height: 500,
            ),
          ),
          Center(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: mySize.height * 0.02),
                    Text(
                      '${medicine.indications}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[700],
                      ),
                    ),
                    SizedBox(height: mySize.height * 0.1),
                    _medicineCard(medicine, mySize),
                    SizedBox(height: mySize.height * 0.02),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Text(
                        '${medicine.description}',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _medicineCard(Medicine medicine, Size mySize) {
  // final myWidth = mySize.width;
  // final myHeight = mySize.height;
  return Column(
    children: [
      Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Container(
            height: mySize.height * 0.40,
            width: mySize.width * 0.9,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 3,
              child: Container(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 30,
                  color: Colors.black12,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          Positioned(
            top: -25,
            left: 25,
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: mySize.height * 0.35,
                child: SlideInRight(
                  duration: Duration(milliseconds: 350),
                  from: 250,
                  child: Image.asset('assets/images/pill_bottle.png'),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${medicine.name}',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[600],
                  ),
                ),
                Text('${medicine.presentation}'),
                Text('Cantidad disponible: ${medicine.stock.toString()}'),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}
