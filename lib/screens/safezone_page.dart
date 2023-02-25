import 'package:cane_9_app/components/safezone_card.dart';
import 'package:flutter/material.dart';
import 'package:cane_9_app/services/safezone.dart';

class SafezonePage extends StatefulWidget {
  const SafezonePage({super.key});

  @override
  State<SafezonePage> createState() => _SafezonePageState();
}

class _SafezonePageState extends State<SafezonePage> {
  List<Safezone> _safezones = [];

  void fetchSafezone() async {
    List<Map<String, String>> fetchedZones = [
      {
        "name": "Home",
        "image": "Safezone/Safezone_1.png",
        "address": "623 Jurong West Street 61, Block 623, #06-019"
      },
      {
        "name": "Pioneer Shopping Mall",
        "image": "Safezone/Safezone_2.png",
        "address": "638 Jurong West Street 61, Singapore 640638"
      },
      {
        "name": "Pier Medical Centre",
        "image": "Safezone/Safezone_3.png",
        "address": "725 Jurong West Ave 5, Singapore 640725"
      },
    ];

    List<Safezone> fetchedZonesWithImage =
        await Future.wait(fetchedZones.map((zone) async {
      Safezone sz = Safezone(zone["name"], zone["address"], zone["image"]);
      await sz.fetchUrl();
      return sz;
    }));

    setState(() {
      _safezones = fetchedZonesWithImage;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSafezone();
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
