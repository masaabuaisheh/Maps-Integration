// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:custom_info_window/custom_info_window.dart';

// class LiveLocationPage extends StatefulWidget {
//   const LiveLocationPage({super.key});

//   @override
//   LiveLocationPageState createState() => LiveLocationPageState();
// }

// class LiveLocationPageState extends State<LiveLocationPage> {
//   GoogleMapController? _mapController;
//   final Location _location = Location();
//   LatLng? _currentPosition;
//   final CustomInfoWindowController _customInfoWindowController =
//       CustomInfoWindowController();
//   MapType _currentMapType = MapType.normal;

//   @override
//   void initState() {
//     super.initState();
//     _getLocation();
//   }

//   void _toggleMapType() {
//     setState(() {
//       _currentMapType =
//           _currentMapType == MapType.normal
//               ? MapType.satellite
//               : MapType.normal;
//     });
//   }

//   void _getLocation() async {
//     bool serviceEnabled;
//     PermissionStatus permissionGranted;

//     serviceEnabled = await _location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await _location.requestService();
//       if (!serviceEnabled) {
//         return;
//       }
//     }

//     permissionGranted = await _location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await _location.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }

//     _location.onLocationChanged.listen((LocationData currentLocation) {
//       if (mounted) {
//         setState(() {
//           _currentPosition = LatLng(
//             currentLocation.latitude!,
//             currentLocation.longitude!,
//           );
//           _mapController?.animateCamera(
//             CameraUpdate.newLatLng(_currentPosition!),
//           );
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFEAD9BE),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFEAD9BE),
//         centerTitle: true,
//         title: const Text(
//           'Where Am I?',
//           style: TextStyle(color: Color(0xFF6A222F), fontSize: 20),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Color(0xFF6A222F)),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             onMapCreated: (GoogleMapController controller) {
//               _mapController = controller;
//               _customInfoWindowController.googleMapController = controller;
//             },
//             mapType: _currentMapType,
//             initialCameraPosition: CameraPosition(
//               target: _currentPosition ?? const LatLng(0, 0),
//               zoom: 15,
//             ),
//             markers: {
//               if (_currentPosition != null)
//                 Marker(
//                   markerId: const MarkerId('currentLocation'),
//                   position: _currentPosition!,
//                   icon: BitmapDescriptor.defaultMarker,
//                   onTap: () {
//                     _customInfoWindowController.addInfoWindow!(
//                       Container(
//                         height: 50,
//                         width: 100,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           border: Border.all(color: Colors.grey),
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         child: const Center(
//                           child: Text(
//                             'You are here',
//                             style: TextStyle(color: Colors.black),
//                           ),
//                         ),
//                       ),
//                       _currentPosition!,
//                     );
//                   },
//                 ),
//               Marker(
//                 markerId: const MarkerId('palestine_label'),
//                 position: const LatLng(30.9, 34.8829571497613),
//                 icon: BitmapDescriptor.defaultMarkerWithHue(
//                   BitmapDescriptor.hueBlue,
//                 ),
//                 infoWindow: const InfoWindow(title: 'Palestine'),
//               ),
//             },
//             onTap: (position) {
//               _customInfoWindowController.hideInfoWindow!();
//             },
//             onCameraMove: (position) {
//               _customInfoWindowController.onCameraMove!();
//             },
//           ),
//           CustomInfoWindow(
//             controller: _customInfoWindowController,
//             height: 50,
//             width: 100,
//             offset: 50,
//           ),
//           Positioned(
//             bottom: 20,
//             left: 20,
//             child: FloatingActionButton(
//               backgroundColor: Colors.white,
//               onPressed: _toggleMapType,
//               child: Icon(
//                 _currentMapType == MapType.normal ? Icons.satellite : Icons.map,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _customInfoWindowController.dispose();
//     super.dispose();
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:custom_info_window/custom_info_window.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class LiveLocationPage extends StatefulWidget {
//   const LiveLocationPage({super.key});

//   @override
//   LiveLocationPageState createState() => LiveLocationPageState();
// }

// class LiveLocationPageState extends State<LiveLocationPage> {
//   GoogleMapController? _mapController;
//   final Location _location = Location();
//   LatLng? _currentPosition;
//   final CustomInfoWindowController _customInfoWindowController =
//       CustomInfoWindowController();
//   MapType _currentMapType = MapType.normal;
//   String _weatherDescription = "Loading...";
//   double _temperature = 0.0;
//   String _weatherIcon = "";

//   @override
//   void initState() {
//     super.initState();
//     _getLocation();
//   }

//   void _toggleMapType() {
//     setState(() {
//       _currentMapType =
//           _currentMapType == MapType.normal
//               ? MapType.satellite
//               : MapType.normal;
//     });
//   }

//   Future<void> _fetchWeather(double lat, double lon) async {
//     const apiKey = "43361fb523ae8719ecbcee1089c67eb5";
//     final url =
//         "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric";
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         setState(() {
//           _weatherDescription = data["weather"][0]["description"];
//           _temperature = data["main"]["temp"];
//           _weatherIcon =
//               "https://openweathermap.org/img/wn/${data["weather"][0]["icon"]}@2x.png";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _weatherDescription = "Failed to load";
//       });
//     }
//   }

//   void _getLocation() async {
//     bool serviceEnabled;
//     PermissionStatus permissionGranted;

//     serviceEnabled = await _location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await _location.requestService();
//       if (!serviceEnabled) return;
//     }

//     permissionGranted = await _location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await _location.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) return;
//     }

//     _location.onLocationChanged.listen((LocationData currentLocation) {
//       if (mounted) {
//         setState(() {
//           _currentPosition = LatLng(
//             currentLocation.latitude!,
//             currentLocation.longitude!,
//           );
//           _mapController?.animateCamera(
//             CameraUpdate.newLatLng(_currentPosition!),
//           );
//           _fetchWeather(currentLocation.latitude!, currentLocation.longitude!);
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFEAD9BE),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFEAD9BE),
//         centerTitle: true,
//         title: const Text(
//           'Where Am I?',
//           style: TextStyle(color: Color(0xFF6A222F), fontSize: 20),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Color(0xFF6A222F)),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             onMapCreated: (GoogleMapController controller) {
//               _mapController = controller;
//               _customInfoWindowController.googleMapController = controller;
//             },
//             mapType: _currentMapType,
//             initialCameraPosition: CameraPosition(
//               target: _currentPosition ?? const LatLng(0, 0),
//               zoom: 15,
//             ),
//             markers: {
//               if (_currentPosition != null)
//                 Marker(
//                   markerId: const MarkerId('currentLocation'),
//                   position: _currentPosition!,
//                   icon: BitmapDescriptor.defaultMarker,
//                   onTap: () {
//                     _customInfoWindowController.addInfoWindow!(
//                       Container(
//                         height: 50,
//                         width: 100,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           border: Border.all(color: Colors.grey),
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         child: const Center(
//                           child: Text(
//                             'You are here',
//                             style: TextStyle(color: Colors.black),
//                           ),
//                         ),
//                       ),
//                       _currentPosition!,
//                     );
//                   },
//                 ),
//               Marker(
//                 markerId: const MarkerId('palestine_label'),
//                 position: const LatLng(30.9, 34.8829571497613),
//                 icon: BitmapDescriptor.defaultMarkerWithHue(
//                   BitmapDescriptor.hueBlue,
//                 ),
//                 infoWindow: const InfoWindow(title: 'Palestine'),
//               ),
//             },
//             onTap: (position) {
//               _customInfoWindowController.hideInfoWindow!();
//             },
//             onCameraMove: (position) {
//               _customInfoWindowController.onCameraMove!();
//             },
//           ),
//           CustomInfoWindow(
//             controller: _customInfoWindowController,
//             height: 50,
//             width: 100,
//             offset: 50,
//           ),
//           Positioned(
//             top: 20,
//             left: 20,
//             child: Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.9),
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
//               ),
//               child: Row(
//                 children: [
//                   if (_weatherIcon.isNotEmpty)
//                     Image.network(_weatherIcon, width: 50, height: 50),
//                   const SizedBox(width: 8),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "${_temperature.toStringAsFixed(1)}°C",
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         _weatherDescription,
//                         style: const TextStyle(fontSize: 14),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 20,
//             left: 20,
//             child: FloatingActionButton(
//               backgroundColor: Colors.white.withOpacity(0.9),
//               onPressed: _toggleMapType,
//               child: Icon(
//                 _currentMapType == MapType.normal ? Icons.satellite : Icons.map,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _customInfoWindowController.dispose();
//     super.dispose();
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:custom_info_window/custom_info_window.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class LiveLocationPage extends StatefulWidget {
//   const LiveLocationPage({super.key});

//   @override
//   LiveLocationPageState createState() => LiveLocationPageState();
// }

// class LiveLocationPageState extends State<LiveLocationPage> {
//   GoogleMapController? _mapController;
//   final Location _location = Location();
//   LatLng? _currentPosition;
//   final CustomInfoWindowController _customInfoWindowController =
//       CustomInfoWindowController();
//   MapType _currentMapType = MapType.normal;
//   String _weatherDescription = "Loading...";
//   double _temperature = 0.0;
//   String _weatherIcon = "";
//   final Map<MarkerId, Marker> _savedMarkers = {}; // Store saved markers
//   final Set<Marker> _markers = {}; // All markers to display on the map

//   @override
//   void initState() {
//     super.initState();
//     _getLocation();
//   }

//   void _toggleMapType() {
//     setState(() {
//       _currentMapType =
//           _currentMapType == MapType.normal
//               ? MapType.satellite
//               : MapType.normal;
//     });
//   }

//   Future<void> _fetchWeather(double lat, double lon) async {
//     const apiKey = "43361fb523ae8719ecbcee1089c67eb5";
//     final url =
//         "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric";
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         setState(() {
//           _weatherDescription = data["weather"][0]["description"];
//           _temperature = data["main"]["temp"];
//           _weatherIcon =
//               "https://openweathermap.org/img/wn/${data["weather"][0]["icon"]}@2x.png";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _weatherDescription = "Failed to load";
//       });
//     }
//   }

//   void _getLocation() async {
//     bool serviceEnabled;
//     PermissionStatus permissionGranted;

//     serviceEnabled = await _location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await _location.requestService();
//       if (!serviceEnabled) return;
//     }

//     permissionGranted = await _location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await _location.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) return;
//     }

//     _location.onLocationChanged.listen((LocationData currentLocation) {
//       if (mounted) {
//         setState(() {
//           _currentPosition = LatLng(
//             currentLocation.latitude!,
//             currentLocation.longitude!,
//           );
//           _mapController?.animateCamera(
//             CameraUpdate.newLatLng(_currentPosition!),
//           );
//           _fetchWeather(currentLocation.latitude!, currentLocation.longitude!);
//         });
//       }
//     });
//   }

//   // Function to prompt user for name and save marker
//   Future<void> _saveLocation(LatLng position) async {
//     final TextEditingController _controller = TextEditingController();
//     String? markerName = await showDialog<String>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Enter Location Name'),
//           content: TextField(
//             controller: _controller,
//             decoration: const InputDecoration(hintText: 'Location name'),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(_controller.text);
//               },
//               child: const Text('Save'),
//             ),
//           ],
//         );
//       },
//     );

//     if (markerName != null && markerName.isNotEmpty) {
//       final MarkerId markerId = MarkerId(markerName);
//       final Marker marker = Marker(
//         markerId: markerId,
//         position: position,
//         infoWindow: InfoWindow(title: markerName),
//         onTap: () {
//           _customInfoWindowController.addInfoWindow!(
//             Container(
//               height: 50,
//               width: 100,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Center(
//                 child: Text(
//                   markerName,
//                   style: const TextStyle(color: Colors.black),
//                 ),
//               ),
//             ),
//             position,
//           );
//         },
//       );

//       setState(() {
//         _savedMarkers[markerId] = marker;
//         _markers.add(marker);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFEAD9BE),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFEAD9BE),
//         centerTitle: true,
//         title: const Text(
//           'Where Am I?',
//           style: TextStyle(color: Color(0xFF6A222F), fontSize: 20),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Color(0xFF6A222F)),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             onMapCreated: (GoogleMapController controller) {
//               _mapController = controller;
//               _customInfoWindowController.googleMapController = controller;
//             },
//             mapType: _currentMapType,
//             initialCameraPosition: CameraPosition(
//               target: _currentPosition ?? const LatLng(0, 0),
//               zoom: 15,
//             ),
//             markers: _markers,
//             onTap: (position) {
//               _customInfoWindowController.hideInfoWindow!();
//               _saveLocation(position); // Save custom marker on tap
//             },
//             onCameraMove: (position) {
//               _customInfoWindowController.onCameraMove!();
//             },
//           ),
//           CustomInfoWindow(
//             controller: _customInfoWindowController,
//             height: 50,
//             width: 100,
//             offset: 50,
//           ),
//           Positioned(
//             top: 20,
//             left: 20,
//             child: Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.9),
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
//               ),
//               child: Row(
//                 children: [
//                   if (_weatherIcon.isNotEmpty)
//                     Image.network(_weatherIcon, width: 50, height: 50),
//                   const SizedBox(width: 8),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "${_temperature.toStringAsFixed(1)}°C",
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         _weatherDescription,
//                         style: const TextStyle(fontSize: 14),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 20,
//             left: 20,
//             child: FloatingActionButton(
//               backgroundColor: Colors.white.withOpacity(0.9),
//               onPressed: _toggleMapType,
//               child: Icon(
//                 _currentMapType == MapType.normal ? Icons.satellite : Icons.map,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _customInfoWindowController.dispose();
//     super.dispose();
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:custom_info_window/custom_info_window.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class LiveLocationPage extends StatefulWidget {
//   const LiveLocationPage({super.key});

//   @override
//   LiveLocationPageState createState() => LiveLocationPageState();
// }

// class LiveLocationPageState extends State<LiveLocationPage> {
//   GoogleMapController? _mapController;
//   final Location _location = Location();
//   LatLng? _currentPosition;
//   final CustomInfoWindowController _customInfoWindowController =
//       CustomInfoWindowController();
//   MapType _currentMapType = MapType.normal;
//   String _weatherDescription = "Loading...";
//   double _temperature = 0.0;
//   String _weatherIcon = "";
//   final Map<MarkerId, Marker> _savedMarkers = {}; // Store saved markers
//   final Set<Marker> _markers = {}; // All markers to display on the map
//   Marker? _liveLocationMarker;

//   @override
//   void initState() {
//     super.initState();
//     _getLocation();
//   }

//   void _toggleMapType() {
//     setState(() {
//       _currentMapType =
//           _currentMapType == MapType.normal
//               ? MapType.satellite
//               : MapType.normal;
//     });
//   }

//   Future<void> _fetchWeather(double lat, double lon) async {
//     const apiKey = "43361fb523ae8719ecbcee1089c67eb5";
//     final url =
//         "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric";
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         setState(() {
//           _weatherDescription = data["weather"][0]["description"];
//           _temperature = data["main"]["temp"];
//           _weatherIcon =
//               "https://openweathermap.org/img/wn/${data["weather"][0]["icon"]}@2x.png";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _weatherDescription = "Failed to load";
//       });
//     }
//   }

//   void _getLocation() async {
//     bool serviceEnabled;
//     PermissionStatus permissionGranted;

//     serviceEnabled = await _location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await _location.requestService();
//       if (!serviceEnabled) return;
//     }

//     permissionGranted = await _location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await _location.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) return;
//     }

//     _location.onLocationChanged.listen((LocationData currentLocation) {
//       if (mounted) {
//         setState(() {
//           _currentPosition = LatLng(
//             currentLocation.latitude!,
//             currentLocation.longitude!,
//           );
//           _mapController?.animateCamera(
//             CameraUpdate.newLatLng(_currentPosition!),
//           );

//           // Update or create the live location marker
//           _liveLocationMarker = Marker(
//             markerId: MarkerId('live_location'),
//             position: _currentPosition!,
//             infoWindow: InfoWindow(title: "You are here"),
//           );

//           _markers.add(_liveLocationMarker!);

//           _fetchWeather(currentLocation.latitude!, currentLocation.longitude!);
//         });
//       }
//     });
//   }

//   // Function to prompt user for name and save marker
//   Future<void> _saveLocation(LatLng position) async {
//     final TextEditingController _controller = TextEditingController();
//     String? markerName = await showDialog<String>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Enter Location Name'),
//           content: TextField(
//             controller: _controller,
//             decoration: const InputDecoration(hintText: 'Location name'),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(_controller.text);
//               },
//               child: const Text('Save'),
//             ),
//           ],
//         );
//       },
//     );

//     if (markerName != null && markerName.isNotEmpty) {
//       final MarkerId markerId = MarkerId(markerName);
//       final Marker marker = Marker(
//         markerId: markerId,
//         position: position,
//         infoWindow: InfoWindow(title: markerName),
//         onTap: () {
//           _customInfoWindowController.addInfoWindow!(
//             Container(
//               height: 50,
//               width: 100,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Center(
//                 child: Text(
//                   markerName,
//                   style: const TextStyle(color: Colors.black),
//                 ),
//               ),
//             ),
//             position,
//           );
//         },
//       );

//       setState(() {
//         _savedMarkers[markerId] = marker;
//         _markers.add(marker);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFEAD9BE),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFEAD9BE),
//         centerTitle: true,
//         title: const Text(
//           'Where Am I?',
//           style: TextStyle(color: Color(0xFF6A222F), fontSize: 20),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Color(0xFF6A222F)),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             onMapCreated: (GoogleMapController controller) {
//               _mapController = controller;
//               _customInfoWindowController.googleMapController = controller;
//             },
//             mapType: _currentMapType,
//             initialCameraPosition: CameraPosition(
//               target: _currentPosition ?? const LatLng(0, 0),
//               zoom: 15,
//             ),
//             markers: _markers,
//             onTap: (position) {
//               _customInfoWindowController.hideInfoWindow!();
//               _saveLocation(position); // Save custom marker on tap
//             },
//             onCameraMove: (position) {
//               _customInfoWindowController.onCameraMove!();
//             },
//           ),
//           CustomInfoWindow(
//             controller: _customInfoWindowController,
//             height: 50,
//             width: 100,
//             offset: 50,
//           ),
//           Positioned(
//             top: 20,
//             left: 20,
//             child: Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.9),
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
//               ),
//               child: Row(
//                 children: [
//                   if (_weatherIcon.isNotEmpty)
//                     Image.network(_weatherIcon, width: 50, height: 50),
//                   const SizedBox(width: 8),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "${_temperature.toStringAsFixed(1)}°C",
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         _weatherDescription,
//                         style: const TextStyle(fontSize: 14),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 20,
//             left: 20,
//             child: FloatingActionButton(
//               backgroundColor: Colors.white.withOpacity(0.9),
//               onPressed: _toggleMapType,
//               child: Icon(
//                 _currentMapType == MapType.normal ? Icons.satellite : Icons.map,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _customInfoWindowController.dispose();
//     super.dispose();
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:custom_info_window/custom_info_window.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class LiveLocationPage extends StatefulWidget {
//   const LiveLocationPage({super.key});

//   @override
//   LiveLocationPageState createState() => LiveLocationPageState();
// }

// class LiveLocationPageState extends State<LiveLocationPage> {
//   GoogleMapController? _mapController;
//   final Location _location = Location();
//   LatLng? _currentPosition;
//   final CustomInfoWindowController _customInfoWindowController =
//       CustomInfoWindowController();
//   MapType _currentMapType = MapType.normal;
//   String _weatherDescription = "Loading...";
//   double _temperature = 0.0;
//   String _weatherIcon = "";
//   final Map<MarkerId, Marker> _savedMarkers = {}; // Store saved markers
//   final Set<Marker> _markers = {}; // All markers to display on the map
//   Marker? _liveLocationMarker;
//   bool _showSavedPlaces = false; // Flag to toggle saved places visibility

//   @override
//   void initState() {
//     super.initState();
//     _getLocation();
//   }

//   void _toggleMapType() {
//     setState(() {
//       _currentMapType =
//           _currentMapType == MapType.normal
//               ? MapType.satellite
//               : MapType.normal;
//     });
//   }

//   Future<void> _fetchWeather(double lat, double lon) async {
//     const apiKey = "43361fb523ae8719ecbcee1089c67eb5";
//     final url =
//         "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric";
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         setState(() {
//           _weatherDescription = data["weather"][0]["description"];
//           _temperature = data["main"]["temp"];
//           _weatherIcon =
//               "https://openweathermap.org/img/wn/${data["weather"][0]["icon"]}@2x.png";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _weatherDescription = "Failed to load";
//       });
//     }
//   }

//   void _getLocation() async {
//     bool serviceEnabled;
//     PermissionStatus permissionGranted;

//     serviceEnabled = await _location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await _location.requestService();
//       if (!serviceEnabled) return;
//     }

//     permissionGranted = await _location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await _location.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) return;
//     }

//     _location.onLocationChanged.listen((LocationData currentLocation) {
//       if (mounted) {
//         setState(() {
//           _currentPosition = LatLng(
//             currentLocation.latitude!,
//             currentLocation.longitude!,
//           );
//           _mapController?.animateCamera(
//             CameraUpdate.newLatLng(_currentPosition!),
//           );

//           // Update or create the live location marker
//           _liveLocationMarker = Marker(
//             markerId: MarkerId('live_location'),
//             position: _currentPosition!,
//             infoWindow: InfoWindow(title: "You are here"),
//           );

//           _markers.add(_liveLocationMarker!);

//           _fetchWeather(currentLocation.latitude!, currentLocation.longitude!);
//         });
//       }
//     });
//   }

//   // Function to prompt user for name and save marker
//   Future<void> _saveLocation(LatLng position) async {
//     final TextEditingController _controller = TextEditingController();
//     String? markerName = await showDialog<String>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Enter Location Name'),
//           content: TextField(
//             controller: _controller,
//             decoration: const InputDecoration(hintText: 'Location name'),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(_controller.text);
//               },
//               child: const Text('Save'),
//             ),
//           ],
//         );
//       },
//     );

//     if (markerName != null && markerName.isNotEmpty) {
//       final MarkerId markerId = MarkerId(markerName);
//       final Marker marker = Marker(
//         markerId: markerId,
//         position: position,
//         infoWindow: InfoWindow(title: markerName),
//         icon: BitmapDescriptor.defaultMarkerWithHue(
//           BitmapDescriptor.hueBlue,
//         ), // Set marker color to blue
//         onTap: () {
//           _customInfoWindowController.addInfoWindow!(
//             Container(
//               height: 50,
//               width: 100,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Center(
//                 child: Text(
//                   markerName,
//                   style: const TextStyle(color: Colors.black),
//                 ),
//               ),
//             ),
//             position,
//           );
//         },
//       );

//       setState(() {
//         _savedMarkers[markerId] = marker;
//         _markers.add(marker);
//       });
//     }
//   }

//   // Toggle saved places visibility
//   void _toggleSavedPlaces() {
//     setState(() {
//       _showSavedPlaces = !_showSavedPlaces;
//       if (_showSavedPlaces) {
//         _markers.addAll(_savedMarkers.values);
//       } else {
//         _markers.removeWhere(
//           (marker) => _savedMarkers.containsKey(marker.markerId),
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFEAD9BE),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFEAD9BE),
//         centerTitle: true,
//         title: const Text(
//           'Where Am I?',
//           style: TextStyle(color: Color(0xFF6A222F), fontSize: 20),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Color(0xFF6A222F)),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             onMapCreated: (GoogleMapController controller) {
//               _mapController = controller;
//               _customInfoWindowController.googleMapController = controller;
//             },
//             mapType: _currentMapType,
//             initialCameraPosition: CameraPosition(
//               target: _currentPosition ?? const LatLng(0, 0),
//               zoom: 15,
//             ),
//             markers: _markers,
//             onTap: (position) {
//               _customInfoWindowController.hideInfoWindow!();
//               _saveLocation(position); // Save custom marker on tap
//             },
//             onCameraMove: (position) {
//               _customInfoWindowController.onCameraMove!();
//             },
//           ),
//           CustomInfoWindow(
//             controller: _customInfoWindowController,
//             height: 50,
//             width: 100,
//             offset: 50,
//           ),
//           Positioned(
//             top: 20,
//             left: 20,
//             child: Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.9),
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
//               ),
//               child: Row(
//                 children: [
//                   if (_weatherIcon.isNotEmpty)
//                     Image.network(_weatherIcon, width: 50, height: 50),
//                   const SizedBox(width: 8),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "${_temperature.toStringAsFixed(1)}°C",
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         _weatherDescription,
//                         style: const TextStyle(fontSize: 14),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 20,
//             left: 20,
//             child: FloatingActionButton(
//               backgroundColor: Colors.white.withOpacity(0.9),
//               onPressed: _toggleMapType,
//               child: Icon(
//                 _currentMapType == MapType.normal ? Icons.satellite : Icons.map,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 100,
//             right: 20,
//             child: FloatingActionButton(
//               backgroundColor: Colors.white.withOpacity(0.9),
//               onPressed: _toggleSavedPlaces,
//               child: const Icon(Icons.location_on, color: Colors.black),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:custom_info_window/custom_info_window.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class LiveLocationPage extends StatefulWidget {
//   const LiveLocationPage({super.key});

//   @override
//   LiveLocationPageState createState() => LiveLocationPageState();
// }

// class LiveLocationPageState extends State<LiveLocationPage> {
//   GoogleMapController? _mapController;
//   final Location _location = Location();
//   LatLng? _currentPosition;
//   final CustomInfoWindowController _customInfoWindowController =
//       CustomInfoWindowController();
//   MapType _currentMapType = MapType.normal;
//   String _weatherDescription = "Loading...";
//   double _temperature = 0.0;
//   String _weatherIcon = "";
//   final Map<MarkerId, Marker> _savedMarkers = {}; // Store saved markers
//   final Set<Marker> _markers = {}; // All markers to display on the map
//   Marker? _liveLocationMarker;

//   // Add flag for saved markers list visibility
//   bool _isSavedMarkersListVisible = false;

//   @override
//   void initState() {
//     super.initState();
//     _getLocation();
//     _markers.add(
//       Marker(
//         markerId: const MarkerId('palestine_label'),
//         position: const LatLng(30.9, 34.8829571497613),
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//         infoWindow: const InfoWindow(title: 'Palestine'),
//       ),
//     );
//   }

//   void _toggleMapType() {
//     setState(() {
//       _currentMapType =
//           _currentMapType == MapType.normal
//               ? MapType.satellite
//               : MapType.normal;
//     });
//   }

//   // Function to toggle the visibility of the saved markers list
//   void _toggleSavedMarkersList() {
//     setState(() {
//       _isSavedMarkersListVisible = !_isSavedMarkersListVisible;
//     });
//   }

//   Future<void> _fetchWeather(double lat, double lon) async {
//     const apiKey = "43361fb523ae8719ecbcee1089c67eb5";
//     final url =
//         "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric";
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         setState(() {
//           _weatherDescription = data["weather"][0]["description"];
//           _temperature = data["main"]["temp"];
//           _weatherIcon =
//               "https://openweathermap.org/img/wn/${data["weather"][0]["icon"]}@2x.png";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _weatherDescription = "Failed to load";
//       });
//     }
//   }

//   void _getLocation() async {
//     bool serviceEnabled;
//     PermissionStatus permissionGranted;

//     serviceEnabled = await _location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await _location.requestService();
//       if (!serviceEnabled) return;
//     }

//     permissionGranted = await _location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await _location.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) return;
//     }

//     _location.onLocationChanged.listen((LocationData currentLocation) {
//       if (mounted) {
//         setState(() {
//           _currentPosition = LatLng(
//             currentLocation.latitude!,
//             currentLocation.longitude!,
//           );
//           _mapController?.animateCamera(
//             CameraUpdate.newLatLng(_currentPosition!),
//           );

//           // Update or create the live location marker
//           _liveLocationMarker = Marker(
//             markerId: const MarkerId('live_location'),
//             position: _currentPosition!,
//             infoWindow: const InfoWindow(title: "You are here"),
//           );

//           _markers.add(_liveLocationMarker!);

//           _fetchWeather(currentLocation.latitude!, currentLocation.longitude!);
//         });
//       }
//     });
//   }

//   // Function to prompt user for name and save marker
//   Future<void> _saveLocation(LatLng position) async {
//     final TextEditingController _controller = TextEditingController();
//     String? markerName = await showDialog<String>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Enter Location Name'),
//           content: TextField(
//             controller: _controller,
//             decoration: const InputDecoration(hintText: 'Location name'),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(_controller.text);
//               },
//               child: const Text('Save'),
//             ),
//           ],
//         );
//       },
//     );

//     if (markerName != null && markerName.isNotEmpty) {
//       final MarkerId markerId = MarkerId(markerName);
//       final Marker marker = Marker(
//         markerId: markerId,
//         position: position,
//         infoWindow: InfoWindow(title: markerName),
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
//         onTap: () {
//           _customInfoWindowController.addInfoWindow!(
//             Container(
//               height: 50,
//               width: 100,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Center(
//                 child: Text(
//                   markerName,
//                   style: const TextStyle(color: Colors.black),
//                 ),
//               ),
//             ),
//             position,
//           );
//         },
//       );

//       setState(() {
//         _savedMarkers[markerId] = marker;
//         _markers.add(marker);
//       });
//     }
//   }

//   // Remove a saved marker
//   void _removeMarker(MarkerId markerId) {
//     setState(() {
//       _savedMarkers.remove(markerId);
//       _markers.removeWhere((marker) => marker.markerId == markerId);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFEAD9BE),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFEAD9BE),
//         centerTitle: true,
//         title: const Text(
//           'Where Am I?',
//           style: TextStyle(color: Color(0xFF6A222F), fontSize: 20),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Color(0xFF6A222F)),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             onMapCreated: (GoogleMapController controller) {
//               _mapController = controller;
//               _customInfoWindowController.googleMapController = controller;
//             },
//             mapType: _currentMapType,
//             initialCameraPosition: CameraPosition(
//               target: _currentPosition ?? const LatLng(0, 0),
//               zoom: 15,
//             ),
//             markers: _markers,
//             onTap: (position) {
//               _customInfoWindowController
//                   .hideInfoWindow!(); // Close info window on map tap
//               _saveLocation(position); // Save custom marker on tap
//             },
//             onCameraMove: (position) {
//               _customInfoWindowController.onCameraMove!();
//             },
//           ),
//           CustomInfoWindow(
//             controller: _customInfoWindowController,
//             height: 50,
//             width: 100,
//             offset: 50,
//           ),
//           Positioned(
//             top: 20,
//             left: 20,
//             child: Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.9),
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
//               ),
//               child: Row(
//                 children: [
//                   if (_weatherIcon.isNotEmpty)
//                     Image.network(_weatherIcon, width: 50, height: 50),
//                   const SizedBox(width: 8),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "${_temperature.toStringAsFixed(1)}°C",
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         _weatherDescription,
//                         style: const TextStyle(fontSize: 14),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 20,
//             left: 20,
//             child: FloatingActionButton(
//               backgroundColor: Colors.white.withOpacity(0.9),
//               onPressed: _toggleMapType,
//               child: Icon(
//                 _currentMapType == MapType.normal ? Icons.satellite : Icons.map,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 100,
//             left: 20,
//             child: FloatingActionButton(
//               backgroundColor: Colors.white.withOpacity(0.9),
//               onPressed: _toggleSavedMarkersList,
//               child: Icon(
//                 _isSavedMarkersListVisible
//                     ? Icons.arrow_upward
//                     : Icons.arrow_downward,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           // Show saved markers list based on the visibility flag
//           if (_isSavedMarkersListVisible)
//             Positioned(
//               bottom: 160,
//               left: 20,
//               child: Container(
//                 height: 60,
//                 width: MediaQuery.of(context).size.width - 40,
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.9),
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
//                 ),
//                 child: ListView(
//                   children:
//                       _savedMarkers.values
//                           .map(
//                             (marker) => ListTile(
//                               title: Text(marker.infoWindow.title ?? "Unnamed"),
//                               trailing: IconButton(
//                                 icon: const Icon(Icons.delete),
//                                 onPressed: () {
//                                   _removeMarker(marker.markerId);
//                                 },
//                               ),
//                             ),
//                           )
//                           .toList(),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LiveLocationPage extends StatefulWidget {
  const LiveLocationPage({super.key});

  @override
  LiveLocationPageState createState() => LiveLocationPageState();
}

class LiveLocationPageState extends State<LiveLocationPage> {
  GoogleMapController? _mapController;
  final Location _location = Location();
  LatLng? _currentPosition;
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  MapType _currentMapType = MapType.normal;
  String _weatherDescription = "Loading...";
  double _temperature = 0.0;
  String _weatherIcon = "";
  final Map<MarkerId, Marker> _savedMarkers = {}; // Store saved markers
  final Set<Marker> _markers = {}; // All markers to display on the map
  Marker? _liveLocationMarker;

  // Add flag for saved markers list visibility
  bool _isSavedMarkersListVisible = false;

  @override
  void initState() {
    super.initState();
    _getLocation();
    // Add a fixed label instead of a marker for Palestine
    _markers.add(
      Marker(
        markerId: const MarkerId('palestine_label'),
        position: const LatLng(30.9, 34.8829571497613),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(title: 'Palestine'),
      ),
    );
  }

  void _toggleMapType() {
    setState(() {
      _currentMapType =
          _currentMapType == MapType.normal
              ? MapType.satellite
              : MapType.normal;
    });
  }

  // Function to toggle the visibility of the saved markers list
  void _toggleSavedMarkersList() {
    setState(() {
      _isSavedMarkersListVisible = !_isSavedMarkersListVisible;
    });
  }

  Future<void> _fetchWeather(double lat, double lon) async {
    const apiKey = "43361fb523ae8719ecbcee1089c67eb5";
    final url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _weatherDescription = data["weather"][0]["description"];
          _temperature = data["main"]["temp"];
          _weatherIcon =
              "https://openweathermap.org/img/wn/${data["weather"][0]["icon"]}@2x.png";
        });
      }
    } catch (e) {
      setState(() {
        _weatherDescription = "Failed to load";
      });
    }
  }

  void _getLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return;
    }

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    _location.onLocationChanged.listen((LocationData currentLocation) {
      if (mounted) {
        setState(() {
          _currentPosition = LatLng(
            currentLocation.latitude!,
            currentLocation.longitude!,
          );
          _mapController?.animateCamera(
            CameraUpdate.newLatLng(_currentPosition!),
          );

          // Update or create the live location marker
          _liveLocationMarker = Marker(
            markerId: const MarkerId('live_location'),
            position: _currentPosition!,
            infoWindow: const InfoWindow(title: "You are here"),
          );

          _markers.add(_liveLocationMarker!);

          _fetchWeather(currentLocation.latitude!, currentLocation.longitude!);
        });
      }
    });
  }

  // Function to prompt user for name and save marker
  Future<void> _saveLocation(LatLng position) async {
    final TextEditingController _controller = TextEditingController();
    String? markerName = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Location Name'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Location name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(_controller.text);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (markerName != null && markerName.isNotEmpty) {
      final MarkerId markerId = MarkerId(markerName);
      final Marker marker = Marker(
        markerId: markerId,
        position: position,
        infoWindow: InfoWindow(title: markerName),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        onTap: () {
          _customInfoWindowController.addInfoWindow!(
            Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  markerName,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            position,
          );
        },
      );

      setState(() {
        _savedMarkers[markerId] = marker;
        _markers.add(marker);
      });
    }
  }

  // Remove a saved marker
  void _removeMarker(MarkerId markerId) {
    setState(() {
      _savedMarkers.remove(markerId);
      _markers.removeWhere((marker) => marker.markerId == markerId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAD9BE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEAD9BE),
        centerTitle: true,
        title: const Text(
          'Where Am I?',
          style: TextStyle(color: Color(0xFF6A222F), fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF6A222F)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
              _customInfoWindowController.googleMapController = controller;
            },
            mapType: _currentMapType,
            initialCameraPosition: CameraPosition(
              target: _currentPosition ?? const LatLng(0, 0),
              zoom: 15,
            ),
            markers: _markers,
            onTap: (position) {
              _customInfoWindowController
                  .hideInfoWindow!(); // Close info window on map tap
              _saveLocation(position); // Save custom marker on tap
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 50,
            width: 100,
            offset: 50,
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
              ),
              child: Row(
                children: [
                  if (_weatherIcon.isNotEmpty)
                    Image.network(_weatherIcon, width: 50, height: 50),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${_temperature.toStringAsFixed(1)}°C",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _weatherDescription,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.white.withOpacity(0.9),
              onPressed: _toggleMapType,
              child: Icon(
                _currentMapType == MapType.normal ? Icons.satellite : Icons.map,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.white.withOpacity(0.9),
              onPressed: _toggleSavedMarkersList,
              child: Icon(
                _isSavedMarkersListVisible
                    ? Icons.arrow_upward
                    : Icons.arrow_downward,
                color: Colors.black,
              ),
            ),
          ),
          if (_isSavedMarkersListVisible)
            Positioned(
              bottom: 160,
              left: 20,
              child: Material(
                color: Colors.white.withOpacity(0.8),
                elevation: 4,
                child: SizedBox(
                  height: 200,
                  width: 300,
                  child: ListView(
                    children:
                        _savedMarkers.entries.map((entry) {
                          return ListTile(
                            title: Text(entry.value.infoWindow.title ?? ''),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _removeMarker(entry.key);
                              },
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
