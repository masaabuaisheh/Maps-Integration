// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class GoogleMapFlutter extends StatefulWidget {
//   const GoogleMapFlutter({super.key});
//
//   @override
//   State<GoogleMapFlutter> createState() => _GoogleMapFlutter();
// }
//
// class _GoogleMapFlutter extends State<GoogleMapFlutter> {
//   LatLng myCurrentLocation = LatLng(31.9522, 35.2332);
//   late GoogleMapController googleMapController;
//   Set<Marker> marker = {};
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         myLocationButtonEnabled: false,
//         markers: marker,
//         onMapCreated: (GoogleMapController contoller) {
//           googleMapController = contoller;
//         },
//         initialCameraPosition: CameraPosition(
//           target: myCurrentLocation,
//           zoom: 8.0,
//         ),
//         // markers: {
//         //   Marker(
//         //     markerId: MarkerId("Marker Id"),
//         //     position: myCurrentLocation,
//         //     draggable: true,
//         //     onDragEnd: (value) {},
//         //     infoWindow: InfoWindow(title: "Nablus", snippet: "more info"),
//         //   ),
//         // },
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.white,
//         onPressed: () async {
//           Position position = await currentPosition();
//           googleMapController.animateCamera(
//             CameraUpdate.newCameraPosition(
//               CameraPosition(
//                 target: LatLng(position.latitude, position.longitude),
//                 zoom: 14,
//               ),
//             ),
//           );
//           // Clearing existing markers
//           marker.clear();
//           // Adding a new marker at the user's current position
//           marker.add(
//             Marker(
//               markerId: const MarkerId('Current Location'),
//               position: LatLng(position.latitude, position.longitude),
//             ),
//           );
//
//           setState(() {});
//         },
//         child: const Icon(Icons.my_location, size: 30),
//       ),
//     );
//   }
//
//   // Function to determine the user's current position
//   Future<Position> currentPosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Checking if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled');
//     }
//
//     // Checking the location permission status
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       // Requesting permission if it is denied
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error("Location permission denied");
//       }
//     }
//
//     // Handling the case where permission is permanently denied
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error('Location permissions are permanently denied');
//     }
//
//     // Getting the current position of the user
//     Position position = await Geolocator.getCurrentPosition();
//     return position;
//   }
// }
//
//
//
//
//
//






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


