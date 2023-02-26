import 'dart:async';
import 'dart:convert';

import 'package:cane_9_app/constants.dart';
import 'package:cane_9_app/screens/info_page.dart';
import 'package:cane_9_app/screens/safezone_page.dart';
import 'package:cane_9_app/services/networking.dart';
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
  bool outOfSafeZone = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void callAlert(bool alert) async {
    if (alert) {
      Networking networking = Networking(path: "/alert/enable");
      networking.httpPost({"patientId": "iZJE99WIH4VQGzWptmDxpV3skpv1"});
    } else {
      Networking networking = Networking(path: "/alert/disable");
      networking.httpPost({"patientId": "iZJE99WIH4VQGzWptmDxpV3skpv1"});
    }
  }

  void pollLocation(Networking networking) async {
    Map<String, dynamic>? data = await networking.httpGet();
    if (data != null) {
      setState(() {
        lat = data["lat"];
        long = data["long"];
        outOfSafeZone = data["outOfSafeZone"];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Networking networking = Networking(
        path: "/location/read?patientId=iZJE99WIH4VQGzWptmDxpV3skpv1");
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      pollLocation(networking);
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
      MapPage(
          alerted: alerted, lat: lat, long: long, outOfSafeZone: outOfSafeZone),
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
                        callAlert(!alerted);
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
  const MapPage(
      {super.key,
      required this.alerted,
      required this.long,
      required this.lat,
      required this.outOfSafeZone});
  final bool alerted;
  final String? lat;
  final String? long;
  final bool outOfSafeZone;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  bool _warningTapped = false;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Circle> circles = {};

  void fetchSafezones(Networking networking) async {
    final fetchedData = await networking.httpGet();
    if (fetchedData != null) {
      int index = 0;
      final fetchedCircles = fetchedData.map<Circle>((data) {
        index++;
        return Circle(
          circleId: CircleId(index.toString()),
          center: LatLng(double.parse(data["lat"]), double.parse(data["long"])),
          radius: data["radius"].toDouble(),
          fillColor: const Color.fromRGBO(179, 222, 193, 0.5),
          strokeWidth: 2,
          strokeColor: const Color.fromRGBO(48, 58, 43, 0.5),
        );
      });
      setState(() {
        circles = {...fetchedCircles};
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("${widget.alerted}");
    Networking networking = Networking(
        path: "/safezone/read?patientId=iZJE99WIH4VQGzWptmDxpV3skpv1");
    fetchSafezones(networking);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                widget.lat == null
                    ? 1.3476701577007462
                    : double.parse(widget.lat!),
                widget.long == null
                    ? 103.6821534386657
                    : double.parse(widget.long!),
              ),
              zoom: 14.0,
            ),
            myLocationButtonEnabled: false,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            markers: {
              Marker(
                markerId: const MarkerId("1"),
                position: LatLng(
                  widget.lat == null
                      ? 1.3476701577007462
                      : double.parse(widget.lat!),
                  widget.long == null
                      ? 103.6821534386657
                      : double.parse(widget.long!),
                ),
              ),
            },
            circles: circles),
        Positioned(
          top: 0,
          left: 150,
          right: 150,
          child: Image.asset("assets/CANE-9 Logo 1.png"),
        ),
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
            backgroundColor: Colors.black,
            child: const Icon(
              Icons.logout,
            ),
          ),
        ),
        Visibility(
          visible: widget.outOfSafeZone,
          child: Positioned(
            top: 16,
            left: 16,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _warningTapped = !_warningTapped;
                });
              },
              child: AnimatedContainer(
                height: _warningTapped ? 46 : 36,
                width: _warningTapped ? 215 : 36,
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: _warningTapped
                    ? Row(
                        children: const [
                          SizedBox(width: 10),
                          Text("ALERT: ",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                                "Winston is outside of the vicinity of Saved Places",
                                softWrap: true,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                )),
                          ),
                          SizedBox(width: 4),
                        ],
                      )
                    : const Icon(
                        Icons.priority_high,
                        color: Colors.white,
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
