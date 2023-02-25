import 'package:cane_9_app/components/safezone_card.dart';
import 'package:flutter/material.dart';
import 'package:cane_9_app/services/safezone.dart';
import 'package:http/http.dart' as http;
import 'package:cane_9_app/services/networking.dart';

class SafezonePage extends StatefulWidget {
  const SafezonePage({super.key});

  @override
  State<SafezonePage> createState() => _SafezonePageState();
}

class _SafezonePageState extends State<SafezonePage> {
  List<Safezone> _safezones = [];

  void fetchSafezone(Networking networking) async {
    // List<Map<String, dynamic>> fetchedZones = [
    //   {
    //     "name": "Home",
    //     "image": "Safezone/Safezone_1.png",
    //     "address": "623 Jurong West Street 61, Block 623, #06-019",
    //     "postal": "",
    //     "radius": "500 m",
    //     "frequencies": ["Often goes here on Tuesdays and Wednesdays"],
    //     "details": ["Only visits the food court and supermarket"]
    //   },
    //   {
    //     "name": "Pioneer Shopping Mall",
    //     "image": "Safezone/Safezone_2.png",
    //     "address": "638 Jurong West Street 61",
    //     "postal": "640638",
    //     "radius": "1 km",
    //     "frequencies": ["Often goes here on Tuesdays and Wednesdays"],
    //     "details": ["Only visits the food court and supermarket"]
    //   },
    //   {
    //     "name": "Pier Medical Centre",
    //     "image": "Safezone/Safezone_3.png",
    //     "address": "725 Jurong West Ave 5",
    //     "postal": "640725",
    //     "radius": "2 km",
    //     "frequencies": ["Often goes here on Tuesdays and Wednesdays"],
    //     "details": ["Only visits the food court and supermarket"]
    //   },
    // ];

    final fetchedZones = await networking.fetchData();

    if (fetchedZones != null) {
      debugPrint("$fetchedZones");
      List<Safezone> fetchedZonesWithImage =
          await Future.wait(fetchedZones.map<Future<Safezone>>((zone) async {
        Safezone sz = Safezone(
            zone["location"],
            zone["address"],
            zone["image"],
            zone["postalCode"],
            zone["radius"],
            List<String>.from(zone["frequencies"]),
            List<String>.from(zone["details"]));
        await sz.fetchUrl();
        return sz;
      }));
      setState(() {
        _safezones = fetchedZonesWithImage;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Networking networking = Networking(
        path: "/safezone/read?patientId=iZJE99WIH4VQGzWptmDxpV3skpv1");
    fetchSafezone(networking);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Saved Places",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                height: 1.67,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Icon(
              Icons.info,
              size: 10,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
        const SizedBox(
          height: 6,
        ),
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: _safezones.length,
            itemBuilder: (BuildContext bctx, int index) {
              return SafezoneCard(
                safezone: _safezones[index],
              );
            }),
      ],
    ));
  }
}
