import 'dart:async';

import 'package:clinic_app/models/users_model.dart';
import 'package:clinic_app/pages/common_states_widgets/build_error.dart';
import 'package:clinic_app/pages/common_states_widgets/build_initial.dart';
import 'package:clinic_app/pages/common_states_widgets/build_loading.dart';
import 'package:clinic_app/providers.dart';
import 'package:clinic_app/providers/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    final MyUser patient = ModalRoute.of(context).settings.arguments;
    context.read(mapProvider).getPatientAddress(patient.userId);
    return Scaffold(
      body: Consumer(
        builder: (context, watch, child) {
          final myMapProvider = watch(mapProvider.state);
          if (myMapProvider is MapLoading) {
            return BuildLoading();
          } else if (myMapProvider is MapError) {
            return BuildError(myMapProvider.message);
          } else if (myMapProvider is MapLoaded) {
            return Map(
              _controller,
              myMapProvider.userPosition,
            );
          }
          return BuildInitial();
        },
      ),
    );
  }
}

class Map extends StatefulWidget {
  final Completer<GoogleMapController> _controller;
  final LatLng position;
  const Map(this._controller, this.position);

  @override
  _MapState createState() => _MapState();
}

@override
void initState() {}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    final String markerIdVal = 'HomeMarker';
    return Stack(
      children: [
        GoogleMap(
          markers: {
            Marker(
              markerId: MarkerId(markerIdVal),
              position:
                  LatLng(widget.position.latitude, widget.position.longitude),
            ),
          },
          liteModeEnabled: true,
          mapType: MapType.hybrid,
          buildingsEnabled: true,
          compassEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.position.latitude, widget.position.longitude),
            zoom: 14,
          ),
          onMapCreated: (GoogleMapController controller) {
            widget._controller.complete(controller);
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
      ],
    );
  }
}
