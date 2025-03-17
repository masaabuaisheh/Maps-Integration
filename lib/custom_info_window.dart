import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomInfoWindowApp extends StatefulWidget {
  const CustomInfoWindowApp({super.key});

  @override
  State<CustomInfoWindowApp> createState() => _CustomInfoWindowAppState();
}

class _CustomInfoWindowAppState extends State<CustomInfoWindowApp> {
  LatLng myCurrentLocation = const LatLng(31.9522, 35.2332);
  final CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();

  Set<Marker> allMarkers = {}; // All markers
  Set<Marker> visibleMarkers = {}; // Markers currently visible on the map

  List<LatLng> pointOnMap = [
    // Mosque
    const LatLng(31.7762835366659, 35.235790928835584),
    const LatLng(31.524897127807456, 35.11069753824127),
    const LatLng(32.233095599017815, 35.2618197479882),
    const LatLng(31.504504416628134, 34.46442137116441),
    const LatLng(32.92293371332268, 35.070505111308556),
    // Church
    const LatLng(31.778636322166154, 35.22956800941533),
    const LatLng(31.70446767419863, 35.20757171126143),
    const LatLng(32.45886831219401, 35.2594228001961),
    const LatLng(32.7023712094989, 35.29733892294418),
    const LatLng(31.953271641479613, 34.89968734010652),
    const LatLng(31.5035835516914, 34.462377397760605),
    const LatLng(31.703587931510903, 35.209277011261484),
    // Religious Sites
    const LatLng(31.707603788515687, 35.22998455174146),
    const LatLng(32.686947633606714, 35.38665370225804),
    const LatLng(32.79031601742265, 35.537125709454244),
    const LatLng(32.96982259447945, 35.4916915959679),
    const LatLng(31.778368620360926, 35.24574115148598),
    const LatLng(32.209693928097245, 35.28544232847207),
    // Islamic Landmarks
    const LatLng(31.77819100238738, 35.23544919009983),
    // Archaeological Sites
    const LatLng(31.869835991992243, 35.44387437873402),
    const LatLng(31.8821918892874, 35.45984680941923),
    // Historic Sites
    const LatLng(32.23300671873817, 34.945443444368415),
    const LatLng(32.46127958315339, 35.28763421561737),
    const LatLng(32.05550103130138, 34.75219660257988),
    const LatLng(31.905244889264665, 35.20423028058456),
    const LatLng(32.96941920848279, 35.49317044482819),
    const LatLng(32.9236, 35.0697),
    const LatLng(31.776535487760192, 35.22841299592197),
    // Museums
    const LatLng(31.911341469741295, 35.208794909420284),
    const LatLng(31.89076457147644, 35.19145599592621),
    const LatLng(31.505610867459694, 34.465869911253975),
    // Castles
    const LatLng(32.923911365100686, 35.07110523829516),
    // Monasteries
    const LatLng(
      32.827433615251685,
      34.970097009455756,
    ), // Stella Maris Monastery
    const LatLng(31.88426898247762, 35.429051451110475),
    // Gardens
    const LatLng(32.813628241045954, 34.98743994938485),
    // Ports
    const LatLng(32.05509895076186, 34.748769577802626),
    const LatLng(32.91939097864908, 35.069172409459334),
    const LatLng(32.827478402779896, 34.9940854754218),
    const LatLng(31.420041290401727, 34.33150294600456),
  ];

  final List<String> locationNames = [
    // Mosque
    "Al-Aqsa Mosque (Jerusalem)",
    "Ibrahimi Mosque (Hebron)",
    "Great Mosque of Nablus (Nablus)",
    "Great Mosque of Gaza (Gaza City)",
    "Al-Jazzar Mosque (Akko)",
    // Church
    "Church of the Holy Sepulchre",
    "Church of the Nativity (Bethlehem)",
    "Burqin Church (Jenin)",
    "Church of the Annunciation (Nazareth)",
    "Church of Saint George (Lod)",
    "Saint Porphyrius Church (Gaza City)",
    "Milk Grotto Church (Bethlehem)",
    // Religious Sites
    "Shepherds’ Field (Bethlehem)",
    "Mount Tabor (Nazareth)",
    "Tomb of Maimonides (Tiberias)",
    "Ari Ashkenazi Synagogue (Safed)",
    "Mount of Olives (Jerusalem)",
    "Jacob’s Well (Nablus)",
    // Islamic Landmarks
    "Dome of the Rock (Jerusalem)",
    // Archaeological Sites
    "Tell es-Sultan (Ancient Jericho)",
    "Hisham’s Palace (Jericho)",
    // Historic Sites
    "Hebron Old City (Hebron)",
    "Jenin Refugee Camp (Jenin)",
    "Jaffa Old City (Jaffa)",
    "Al-Manara Square (Ramallah)",
    "Safed Old City (Safed)",
    "Khan al-Umdan (Caravanserai) (Akko)",
    "Tower of David (Jerusalem Citadel)",
    // Museums
    "Yasser Arafat Museum (Ramallah)",
    "Mahmoud Darwish Museum (Ramallah)",
    "Pasha’s Palace Museum (Gaza City)",
    // Castles
    "Akko Citadel (Akko)",
    // Monasteries
    "Stella Maris Monastery (Haifa)",
    "Deir al Krntl (Jericho)",
    // Gardens
    "Haifa Bahai Gardens (Haifa)",
    // Ports
    "Jaffa Port (Jaffa)",
    "Akko Port (Akko)",
    "Haifa Port (Haifa)",
    "Gaza Port (Gaza)",
  ];

  final List<String> locationImage = [
    // Mosque
    'assets/mosque/Al-AqsaMosque.jpg',
    'assets/mosque/IbrahimiMosque.jpg',
    'assets/mosque/GreatMosqueofNablus.jpg',
    'assets/mosque/GreatMosqueofGaza.jpg',
    'assets/mosque/Al-JazzarMosque.jpg',
    // Church
    'assets/church/ChurchoftheHolySepulchre(Jerusalem).jpg',
    'assets/church/ChurchoftheNativity(Bethlehem).jpg',
    'assets/church/BurqinChurch(Jenin).jpg',
    'assets/church/ChurchoftheAnnunciation.jpg',
    'assets/church/ChurchofSaintGeorge(Lod).jpg',
    'assets/church/SaintPorphyriusChurch(GazaCity).jpg',
    'assets/church/MilkGrottoChurch(Bethlehem).jpg',
    // Religious Sites
    'assets/religious_sites/ShepherdsField(Bethlehem).jpg',
    'assets/religious_sites/MountTabor(Nazareth).jpg',
    'assets/religious_sites/TombofMaimonides(Tiberias).jpg',
    'assets/religious_sites/AriAshkenaziSynagogue(Safed).jpg',
    'assets/religious_sites/MountofOlives(Jerusalem).jpg',
    'assets/religious_sites/JacobsWell(Nablus).jpg',
    // Islamic Landmarks
    'assets/islamic_landmarks/DomeoftheRock(Jerusalem).jpg',
    // Archaeological Sites
    'assets/archaeological_sites/Telles-Sultan(Ancient Jericho)(Jericho).jpg',
    'assets/archaeological_sites/HishamPalace(Jericho).jpg',
    // Historic Sites
    'assets/historic_sites/HebronOldCity(Hebron).jpg',
    'assets/historic_sites/JeninRefugeeCamp(Jenin).jpg',
    'assets/historic_sites/JaffaOldCity(Jaffa).jpg',
    'assets/historic_sites/Al-ManaraSquare(Ramallah).jpg',
    'assets/historic_sites/SafedOldCity(Safed).jpg',
    'assets/historic_sites/KhanAlUmdan(Akko).jpg',
    'assets/historic_sites/TowerofDavid(Jerusalem).jpg',
    // Museums
    'assets/museums/YasserArafatMuseum(Ramallah).jpg',
    'assets/museums/MahmoudDarwishMuseum(Ramallah).jpg',
    'assets/museums/PashasPalaceMuseum(GazaCity).jpg',
    // Castles
    'assets/castles/AkkoCitadel(Akko).jpg',
    // Monasteries
    'assets/monasteries/StellaMarisMonastery(Haifa).jpg',
    'assets/monasteries/DeirAlKrntl(Jericho).jpg',
    // Gardens
    'assets/gardens/bahai-gardens.jpg',
    // Ports
    'assets/ports/JaffaPort(Jaffa).jpg',
    'assets/ports/AkkoPort.jpg',
    'assets/ports/HaifaPort.jpg',
    'assets/ports/GazaPort.jpg',
  ];

  final List<String> locationTypes = [
    // Mosque
    "Mosque",
    "Mosque",
    "Mosque",
    "Mosque",
    "Mosque",
    // Church
    "Church",
    "Church",
    "Church",
    "Church",
    "Church",
    "Church",
    "Church",
    // Religious Sites
    "Religious Sites",
    "Religious Sites",
    "Religious Sites",
    "Religious Sites",
    "Religious Sites",
    "Religious Sites",
    // Islamic Landmarks
    "Islamic Landmarks",
    // Archaeological Sites
    "Archaeological Sites",
    "Archaeological Sites",
    // Historic Sites
    "Historic Sites",
    "Historic Sites",
    "Historic Sites",
    "Historic Sites",
    "Historic Sites",
    "Historic Sites",
    "Historic Sites",
    // Museums
    "Museums",
    "Museums",
    "Museums",
    // Castles
    "Castles",
    // Monasteries
    "Monasteries",
    "Monasteries",
    // Gardens
    "Gardens",
    // Ports
    "Ports",
    "Ports",
    "Ports",
    "Ports",
  ];

  String selectedType = "All"; // Default filter: show all markers

  final Map<String, BitmapDescriptor> markerIcons = {
    "Mosque": BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    "Church": BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    "Religious Sites": BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueMagenta,
    ),
    "Islamic Landmarks": BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueYellow,
    ),
    "Archaeological Sites": BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueAzure,
    ),
    "Historic Sites": BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueBlue,
    ),
    "Museums": BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    "Castles": BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueViolet,
    ),
    "Monasteries": BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueRose,
    ),
    "Gardens": BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueYellow,
    ),
    "Ports": BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
  };

  @override
  void initState() {
    super.initState();
    _initializeMarkers();
  }

  void _initializeMarkers() {
    allMarkers.add(
      Marker(
        markerId: const MarkerId('palestine_label'),
        position: const LatLng(30.9, 34.8829571497613),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(title: 'Palestine'),
      ),
    );

    for (int i = 0; i < pointOnMap.length; i++) {
      allMarkers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: pointOnMap[i],
          icon: markerIcons[locationTypes[i]] ?? BitmapDescriptor.defaultMarker,
          onTap: () {
            customInfoWindowController.addInfoWindow!(
              _buildInfoWindow(i),
              pointOnMap[i],
            );
          },
        ),
      );
    }

    visibleMarkers = allMarkers;
    setState(() {});
  }

  Widget _buildInfoWindow(int index) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            locationImage[index],
            height: 100,
            width: 100,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error);
            },
          ),
          const SizedBox(height: 8.0),
          Text(
            locationNames[index],
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _filterMarkers(String type) {
    setState(() {
      if (type == "All") {
        visibleMarkers = allMarkers;
      } else {
        visibleMarkers =
            allMarkers.where((marker) {
              if (marker.markerId.value == 'palestine_label') return true;
              final int index = int.parse(marker.markerId.value);
              return locationTypes[index] == type;
            }).toSet();
      }
    });
  }

  Widget _buildFilterTile(String type, IconData icon, Color color) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(type),
      tileColor:
          selectedType == type
              // ignore: deprecated_member_use
              ? color.withOpacity(0.2)
              : null, // Highlight selected filter
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: selectedType == type ? color : Colors.transparent,
          width: 2,
        ),
      ),
      onTap: () {
        setState(() => selectedType = type);
        _filterMarkers(type);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            myLocationButtonEnabled: false,
            initialCameraPosition: CameraPosition(
              target: myCurrentLocation,
              zoom: 8.0,
            ),
            markers: visibleMarkers,
            onMapCreated: (GoogleMapController controller) {
              customInfoWindowController.googleMapController = controller;
            },
            onTap: (LatLng position) {
              customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (CameraPosition position) {
              customInfoWindowController.onCameraMove!();
            },
          ),
          CustomInfoWindow(
            controller: customInfoWindowController,
            height: 155,
            width: 250,
            offset: 20,
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      constraints: BoxConstraints(
                        maxHeight:
                            MediaQuery.of(context).size.height *
                            0.8, // Limit height
                      ),
                      child: SingleChildScrollView(
                        // Allow scrolling
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Filter by Type',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ...[
                              _buildFilterTile(
                                'All',
                                Icons.all_inclusive,
                                Colors.grey,
                              ),
                              _buildFilterTile(
                                'Mosque',
                                Icons.mosque,
                                Colors.green,
                              ),
                              _buildFilterTile(
                                'Church',
                                Icons.church,
                                Colors.orange,
                              ),
                              _buildFilterTile(
                                'Religious Sites',
                                Icons.temple_buddhist,
                                Colors.purple,
                              ),
                              _buildFilterTile(
                                'Islamic Landmarks',
                                Icons.mosque_sharp,
                                Colors.yellow,
                              ),
                              _buildFilterTile(
                                'Archaeological Sites',
                                Icons.landscape,
                                Colors.blueAccent,
                              ),
                              _buildFilterTile(
                                'Historic Sites',
                                Icons.history,
                                Colors.blue,
                              ),
                              _buildFilterTile(
                                'Museums',
                                Icons.museum,
                                Colors.red,
                              ),
                              _buildFilterTile(
                                'Castles',
                                Icons.castle,
                                Colors.purple,
                              ),
                              _buildFilterTile(
                                'Monasteries',
                                Icons.temple_buddhist,
                                Colors.pink,
                              ),
                              _buildFilterTile(
                                'Gardens',
                                Icons.spa,
                                Colors.yellowAccent,
                              ),
                              _buildFilterTile(
                                'Ports',
                                Icons.directions_boat,
                                Colors.teal,
                              ),
                            ],
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Icon(Icons.filter_list),
            ),
          ),
        ],
      ),
    );
  }
}
