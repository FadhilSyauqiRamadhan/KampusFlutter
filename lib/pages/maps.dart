import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class KampusMaps extends StatelessWidget {
  final double latitude;
  final double longitude;

  const KampusMaps({required this.latitude, required this.longitude, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: MarkerId('kampus'),
            position: LatLng(latitude, longitude),
          ),
        },
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
      ),
    );
  }
}