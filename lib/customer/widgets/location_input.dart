import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../screens/map_screen.dart';
import 'package:kabab/customer/helper/location_helper.dart';
import 'package:geocoder/geocoder.dart';

class LocationInput extends StatefulWidget {
  final Function callbackforLocation;

  LocationInput(this.callbackforLocation);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;
  String _addressToShow;
  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );
    widget.callbackforLocation(a: LatLng(lat, lng));
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _showAddress(double lat, double lng) async {
    // final staticAddressToShow = await LocationHelper.getPlaceAddress(lat, lng);
    var coordinates = new Coordinates(lat, lng);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    setState(() {
      _addressToShow = addresses.first.addressLine;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();
      _showPreview(locData.latitude, locData.longitude);
      _showAddress(locData.latitude, locData.longitude);
    } catch (error) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    print('test1');
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    _showAddress(selectedLocation.latitude, selectedLocation.latitude);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 10,
              ),
              ElevatedButton.icon(
                style: ButtonStyle(),
                onPressed: _getCurrentUserLocation,
                icon: Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                ),
                label: Text(
                  'موقعك الحالى',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              ElevatedButton.icon(
                style: ButtonStyle(),
                onPressed: _selectOnMap,
                icon: Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                ),
                label: Text(
                  'حدد عنوان آخر',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          Container(
            height: 130,
            width: double.infinity,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.teal),
            ),
            child: _previewImageUrl == null
                ? Text(
                    'لم تضف أى عنوان',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.teal),
                  )
                : Image.network(
                    _previewImageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
          ),
          Card(
            color: Colors.teal,
            elevation: 15,
            child: Container(
              height: 70,
              width: double.infinity,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              color: Colors.white,
              child: Center(
                  child: _addressToShow == null
                      ? Text('.....')
                      : Text(_addressToShow)),
            ),
          ),
        ],
      ),
    );
  }
}
