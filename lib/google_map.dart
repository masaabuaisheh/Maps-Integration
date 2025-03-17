import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapFlutter extends StatefulWidget {
  const GoogleMapFlutter({super.key});

  @override
  State<GoogleMapFlutter> createState() => _GoogleMapFlutter();
}

class _GoogleMapFlutter extends State<GoogleMapFlutter> {
  LatLng myCurrentLocation = LatLng(31.9522, 35.2332);
  late GoogleMapController googleMapController;
  Set<Marker> marker = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: myCurrentLocation,
          zoom: 8.0,
        ),
        markers: {
          Marker(
            markerId: MarkerId("Marker Id"),
            position: myCurrentLocation,
            draggable: true,
            onDragEnd: (value) {},
            infoWindow: InfoWindow(title: "Nablus", snippet: "more info"),
          ),
        },
      ),
    );
  }
}


