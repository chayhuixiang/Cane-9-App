import 'dart:async';
import 'dart:convert';

import 'package:cane_9_app/constants.dart';
import 'package:cane_9_app/screens/info_page.dart';
import 'package:cane_9_app/screens/safezone_page.dart';
import 'package:cane_9_app/services/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cane_9_app/screens/add_location_map_page.dart';
import 'package:http/http.dart' as http;

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedPageIndex = 1;
  bool alerted = false;
  Timer? timer;
  String? lat;
  String? long;
  bool? outOfSafeZone;

  void _onItemTapped(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void pollLocation() async {
    String url = '$apiurl/location/read';

    debugPrint("Polling $url...");
    final response = await http.get(Uri.parse(
        '$apiurl/location/read?patientId=iZJE99WIH4VQGzWptmDxpV3skpv1'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
    }
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      pollLocation();
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      const InfoPage(),
      MapPage(alerted),
      const SafezonePage(),
    ];

    final List<dynamic> fabOptions = [
      null,
      {
        "onPressed": () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                contentPadding: const EdgeInsets.only(
                  left: 25,
                  right: 25,
                  top: 40,
                ),
                content: alerted
                    ? const Text(
                        "You are about the switch off the speaker on Winston’s cane. \n\nConfirm to deactivate?",
                        textAlign: TextAlign.center,
                      )
                    : const Text(
                        "You are about to activate the speaker on Winston’s cane to call for the attention of passers-by. \n\nConfirm to proceed?",
                        textAlign: TextAlign.center,
                      ),
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                actionsPadding: const EdgeInsets.only(
                  top: 16,
                  bottom: 27,
                ),
                actions: <Widget>[
                  CircleAvatar(
                    backgroundColor: alerted
                        ? const Color.fromRGBO(99, 187, 128, 1)
                        : Theme.of(context).colorScheme.primaryContainer,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          alerted = !alerted;
                        });
                      },
                      icon: const Icon(
                        Icons.done,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: const Color.fromRGBO(112, 112, 112, 1),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        "icon": alerted
            ? const Icon(
                Icons.volume_up,
                color: Colors.white,
              )
            : const Icon(
                Icons.volume_up,
                color: Colors.black,
              ),
        "backgroundColor": alerted
            ? Theme.of(context).colorScheme.primaryContainer
            : Colors.white,
      },
      {
        "onPressed": () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (buildCtx) => const AddLocationMapPage(),
            ),
          );
        },
        "icon": const Icon(Icons.add),
        "backgroundColor": Theme.of(context).colorScheme.primary,
      }
    ];

    return Scaffold(
      body: SafeArea(child: widgetOptions[_selectedPageIndex]),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: fabOptions[_selectedPageIndex] == null
          ? null
          : FloatingActionButton(
              heroTag: "btmBtn",
              onPressed: fabOptions[_selectedPageIndex]["onPressed"],
              backgroundColor: fabOptions[_selectedPageIndex]
                  ["backgroundColor"],
              child: fabOptions[_selectedPageIndex]["icon"],
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: "Location",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.push_pin),
            label: "Saved",
          ),
        ],
        onTap: _onItemTapped,
        currentIndex: _selectedPageIndex,
      ),
    );
  }
}

class MapPage extends StatefulWidget {
  const MapPage(this.alerted, {super.key});
  final bool alerted;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(1.3485136904488333, 103.68317761246088);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  final Set<Circle> _circles = {
    const Circle(
      circleId: CircleId("1"),
      center: LatLng(1.3485136904488333, 103.68317761246088),
      radius: 1000,
      fillColor: Color.fromRGBO(244, 67, 54, 0.299),
      strokeWidth: 2,
      strokeColor: Color.fromRGBO(244, 67, 54, 1),
    )
  };

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Visibility(
          visible: widget.alerted,
          child: Positioned(
              left: 24,
              right: 81,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    18,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Winston’s cane speaker is activated. Please standby for any calls from passers-by",
                    maxLines: 3,
                    softWrap: true,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                  ),
                ),
              )),
        ),
        Positioned(
          right: 16,
          top: 8,
          child: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              heroTag: "topBtn",
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(Icons.logout)),
        ),
        const Center(
          child: Text("This is the map page."),
        ),
      ],
    );
  }
}

// Map Widget: 
// GoogleMap(
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: CameraPosition(
//           target: _center,
//           zoom: 14.0,
//         ),
//         myLocationButtonEnabled: false,
//         zoomGesturesEnabled: true,
//         zoomControlsEnabled: true,
//         markers: {
//           const Marker(
//             markerId: MarkerId("1"),
//             position: LatLng(1.3485136904488333, 103.68317761246088),
//           ),
//         },
//         circles: _circles);
