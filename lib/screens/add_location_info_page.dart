import 'package:cane_9_app/components/label_title.dart';
import 'package:cane_9_app/components/pageheaders.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class AddLocationInfoPage extends StatefulWidget {
  const AddLocationInfoPage({super.key, required this.placemark});
  final Placemark placemark;

  @override
  State<AddLocationInfoPage> createState() => _AddLocationInfoPageState();
}

class _AddLocationInfoPageState extends State<AddLocationInfoPage> {
  String? _safezoneRadius;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            const PageHeaders(title: "Add Location"),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      bottom: 10,
                      top: 18,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                            "Save a location to add a 'Safe Zone'\nCaregivers will only receive a notification when the elderly leaves this Safe Zone."),
                        Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                              child: const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/Patient_1.png'),
                                radius: 86,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 11,
                              child: Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 4,
                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                          spreadRadius: 4),
                                    ]),
                                child: CircleAvatar(
                                  radius: 17,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.tertiary,
                                  child: const Icon(Icons.add,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const LabelTitle("Set Safe Zone Radius"),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio<String?>(
                                      value: "500 m",
                                      activeColor:
                                          Theme.of(context).colorScheme.primary,
                                      groupValue: _safezoneRadius,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: const VisualDensity(
                                        horizontal:
                                            VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity,
                                      ),
                                      onChanged: (String? value) {
                                        setState(() => _safezoneRadius = value);
                                      }),
                                  const Text("500 m"),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Radio<String?>(
                                      value: "1 km",
                                      activeColor:
                                          Theme.of(context).colorScheme.primary,
                                      groupValue: _safezoneRadius,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: const VisualDensity(
                                        horizontal:
                                            VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity,
                                      ),
                                      onChanged: (String? value) {
                                        setState(() => _safezoneRadius = value);
                                      }),
                                  const Text("1 km"),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Radio<String?>(
                                      value: "2 km",
                                      activeColor:
                                          Theme.of(context).colorScheme.primary,
                                      groupValue: _safezoneRadius,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: const VisualDensity(
                                        horizontal:
                                            VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity,
                                      ),
                                      onChanged: (String? value) {
                                        setState(() => _safezoneRadius = value);
                                      }),
                                  const Text("2 km"),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 7),
                        const LabelTitle("Additional Notes"),
                        Row(
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.black,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
