import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kabab/models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapScreen({
    this.initialLocation,
    this.isSelecting = false,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    print('tesset');
    return Scaffold(
      appBar: AppBar(
        title: Text('الخريطة'),
      ),
      body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
              widget.initialLocation.latitude,
              widget.initialLocation.longitude,
            ),
            zoom: 16,
          ),
          onTap: null,
          markers: {
            Marker(
              markerId: MarkerId('m1'),
              position: LatLng(
                widget.initialLocation.latitude,
                widget.initialLocation.longitude,
              ),
            ),
          }),
    );
  }
}
//
