import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapState {
  const MapState();
}

class MapInitial extends MapState {
  const MapInitial();
}

class MapLoading extends MapState {
  const MapLoading();
}

class MapError extends MapState {
  final String message;
  MapError(this.message);
}

class MapLoaded extends MapState {
  final LatLng userPosition;
  const MapLoaded(this.userPosition);
}
