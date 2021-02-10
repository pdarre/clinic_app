import 'dart:async';

import 'package:clinic_app/models/users_model.dart';
import 'package:clinic_app/pages/common_states_widgets/build_error.dart';
import 'package:clinic_app/pages/common_states_widgets/build_loading.dart';
import 'package:clinic_app/services/map_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final String userId = ModalRoute.of(context).settings.arguments;
    final userLocation =
        watch(getUserLocationByIdPatientFutureProvider(userId));
    return userLocation.when(
      loading: () => BuildLoading(),
      error: (error, stack) => BuildError(error.toString()),
      data: (data) => UserLocationPage(data),
    );
  }
}

class UserLocationPage extends StatefulWidget {
  final LatLng location;
  const UserLocationPage(this.location);

  @override
  State<UserLocationPage> createState() => UserLocationPageState();
}

class UserLocationPageState extends State<UserLocationPage> {
  Completer<GoogleMapController> _controller = Completer();

  MapType _myMapType = MapType.hybrid;

  @override
  Widget build(BuildContext context) {
    // final MyUser patient = ModalRoute.of(context).settings.arguments;
    final String markerIdVal = 'HomeMarker';
    return new Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            markers: {
              Marker(
                markerId: MarkerId(markerIdVal),
                position: widget.location,
                // position: LatLng(
                //     patient.location.latitude, patient.location.longitude),
              ),
            },
            mapType: _myMapType,
            buildingsEnabled: true,
            compassEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: widget.location,
              // LatLng(patient.location.latitude, patient.location.longitude),
              zoom: 14,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Container(
            child: Positioned(
              top: 25,
              left: 5,
              child: IconButton(
                  icon: Icon(FontAwesomeIcons.chevronCircleLeft,
                      size: 25, color: Colors.blueGrey[100]),
                  onPressed: () => Navigator.of(context).pop()),
            ),
          ),
          Container(
            child: Positioned(
              top: 25,
              right: 5,
              child: IconButton(
                icon: Icon(FontAwesomeIcons.mapSigns,
                    size: 25, color: Colors.white),
                onPressed: () {
                  setState(() {
                    (_myMapType == MapType.hybrid)
                        ? _myMapType = MapType.normal
                        : _myMapType = MapType.hybrid;
                  });
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blueGrey,
        onPressed: () {
          _goToTheLake(widget.location);
        },
        label: Text('To the house!'),
        icon: Icon(Icons.house),
      ),
    );
  }

  Future<void> _goToTheLake(LatLng location) async {
    CameraPosition _kLake = CameraPosition(
        bearing: 190,
        target: LatLng(location.latitude, location.longitude),
        tilt: 60,
        zoom: 20);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
