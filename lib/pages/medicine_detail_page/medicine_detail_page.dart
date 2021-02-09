import 'package:animate_do/animate_do.dart';
import 'package:clinic_app/models/medicine_model.dart';
import 'package:clinic_app/pages/common_states_widgets/app_common_background.dart';
import 'package:clinic_app/pages/common_states_widgets/common_app_bar.dart';
import 'package:clinic_app/pages/lost_connection_page/lost_connection_page.dart';
import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:flutter/material.dart';

class MedicineDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Medicine medicine = ModalRoute.of(context).settings.arguments;
    final mySize = MediaQuery.of(context).size;
    return ConnectivityBuilder(
      builder: (context, isConnected, status) {
        if (isConnected != null && isConnected) {
          return Scaffold(
            appBar: CommonAppBar(medicine.name),
            body: MedicineDetailBody(mySize, medicine),
          );
        } else {
          return ConnectionLostPage();
        }
      },
    );
  }
}

class MedicineDetailBody extends StatelessWidget {
  final Size mySize;
  final Medicine medicine;
  const MedicineDetailBody(this.mySize, this.medicine);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppCommonBackground(),
        // Positioned(
        //   left: -200,
        //   bottom: -200,
        //   child: Image.asset(
        //     'assets/images/logo.png',
        //     color: Colors.black12,
        //     height: 500,
        //   ),
        // ),
        // Positioned(
        //   right: -200,
        //   top: -200,
        //   child: Image.asset(
        //     'assets/images/logo.png',
        //     color: Colors.black12,
        //     height: 500,
        //   ),
        // ),
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
                  MedicineCard(medicine, mySize),
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
    );
  }
}

class MedicineCard extends StatelessWidget {
  final Medicine medicine;
  final Size mySize;
  const MedicineCard(this.medicine, this.mySize);
  @override
  Widget build(BuildContext context) {
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
}
