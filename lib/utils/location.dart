import 'package:alert_us/utils/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterLocationPicker(
        urlTemplate:
            'https://api.mapbox.com/styles/v1/anshumali-suri/clgae5bab005j01lacqdx1wq9/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYW5zaHVtYWxpLXN1cmkiLCJhIjoiY2xnYWM0dGpjMWcycTNlcWwwbG9zcmFjaCJ9.yZq0CsGoVUVgRo2j2FMzPA',
        // initPosition: LatLong(23, 89),
        selectLocationButtonStyle: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.blue),
        ),
        selectLocationButtonText: 'Set Current Location',
        initZoom: 11,
        minZoomLevel: 5,
        maxZoomLevel: 16,
        trackMyPosition: true,
        onError: (e) => print(e),
        onPicked: (pickedData) {
          address[0] = pickedData.latLong.latitude.toString();
          address[1] = pickedData.latLong.longitude.toString();
          address[2] = pickedData.address;
          Navigator.pop(context, address);
          // Navigator.of(context)
          //     .pushReplacement(MaterialPageRoute(builder: (context) {
          //   return SignUp();
          // }));
        },

        // loadingWidget: SignUp(),
      ),
    );
  }
}
