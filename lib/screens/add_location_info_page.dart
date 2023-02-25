import 'package:cane_9_app/components/label_title.dart';
import 'package:cane_9_app/components/pageheaders.dart';
import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cane_9_app/services/firebase_image.dart';
import 'dart:io';
import 'package:cane_9_app/services/networking.dart';

class AddLocationInfoPage extends StatefulWidget {
  const AddLocationInfoPage(
      {super.key,
      required this.placemark,
      required this.latitude,
      required this.longitude});
  final Placemark placemark;
  final double latitude;
  final double longitude;

  @override
  State<AddLocationInfoPage> createState() => _AddLocationInfoPageState();
}

class _AddLocationInfoPageState extends State<AddLocationInfoPage> {
  int? _safezoneRadius;
  bool _showDropdown = false;
  List<Map<String, String>> notes = [];
  final TextEditingController _newNoteController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  ImageProvider<Object>? _safezoneImage =
      const AssetImage('assets/Placeholder.png');
  String? imagePath;

  void createSafezone() async {
    debugPrint("Creating safezone...");
    Networking networking = Networking(path: "/safezone/create");

    List<String> frequencies = [];
    List<String> details = [];
    for (var note in notes) {
      if (note["type"] == "frequency" && note["note"] != null) {
        frequencies.add(note["note"]!);
      } else if (note["type"] == "detail" && note["note"] != null) {
        frequencies.add(note["note"]!);
      }
    }

    final payload = {
      "patientId": "iZJE99WIH4VQGzWptmDxpV3skpv1",
      "location": widget.placemark.street.toString(),
      "postalCode": widget.placemark.postalCode.toString(),
      "address": widget.placemark.street.toString(),
      "lat": widget.latitude,
      "long": widget.longitude,
      "radius": _safezoneRadius,
      "image": imagePath,
      "frequencies": frequencies,
      "details": details,
    };

    await networking.httpPost(payload);
    debugPrint("Successful Post");

    int count = 0;
    Navigator.popUntil(context, (route) => count++ == 2);
  }

  @override
  Widget build(BuildContext context) {
    const List<String> list = <String>["One", "Two", "Three"];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const PageHeaders(title: "Add Location"),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: DeferredPointerHandler(
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
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                              "Save a location to add a 'Safe Zone'\nCaregivers will only receive a notification when the elderly leaves this Safe Zone."),
                          Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                                child: CircleAvatar(
                                  backgroundImage: _safezoneImage,
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
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.25),
                                            spreadRadius: 4),
                                      ]),
                                  child: GestureDetector(
                                    onTap: () async {
                                      final XFile? selectedImage =
                                          await _picker.pickImage(
                                              source: ImageSource.gallery);
                                      if (selectedImage != null) {
                                        FirebaseImage fi = FirebaseImage();
                                        final File imageFile =
                                            File(selectedImage.path);
                                        await fi.uploadImage(
                                            imageFile, 'Safezone/');
                                        imagePath =
                                            "Safezone/${imageFile.path}";
                                        setState(() {
                                          _safezoneImage = FileImage(imageFile);
                                        });
                                      }
                                    },
                                    child: CircleAvatar(
                                      radius: 17,
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      child: const Icon(Icons.add,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          const LabelTitle("Name of Place"),
                          const SizedBox(height: 2),
                          Container(
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                  top: 3, bottom: 3, left: 3),
                              color: const Color.fromRGBO(217, 217, 217, 1),
                              child: Text(widget.placemark.name.toString())),
                          const SizedBox(height: 7),
                          const LabelTitle("Address"),
                          const SizedBox(height: 2),
                          Container(
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                  top: 3, bottom: 3, left: 3),
                              color: const Color.fromRGBO(217, 217, 217, 1),
                              child: Text(widget.placemark.street.toString())),
                          const SizedBox(height: 7),
                          const LabelTitle("Postal Code"),
                          const SizedBox(height: 2),
                          Container(
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                  top: 3, bottom: 3, left: 3),
                              color: const Color.fromRGBO(217, 217, 217, 1),
                              child:
                                  Text(widget.placemark.postalCode.toString())),
                          const SizedBox(height: 7),
                          const LabelTitle("Set Safe Zone Radius"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Radio<int>(
                                        value: 500,
                                        activeColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        groupValue: _safezoneRadius,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity,
                                        ),
                                        onChanged: (int? value) {
                                          setState(
                                              () => _safezoneRadius = value);
                                        }),
                                    const Text("500 m"),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Radio<int>(
                                        value: 1000,
                                        activeColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        groupValue: _safezoneRadius,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity,
                                        ),
                                        onChanged: (int? value) {
                                          setState(
                                              () => _safezoneRadius = value);
                                        }),
                                    const Text("1 km"),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Radio<int>(
                                        value: 2000,
                                        activeColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        groupValue: _safezoneRadius,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity,
                                        ),
                                        onChanged: (int? value) {
                                          setState(
                                              () => _safezoneRadius = value);
                                        }),
                                    const Text("2 km"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 7),
                          const LabelTitle("Additional Notes"),
                          const SizedBox(height: 2),
                          Flexible(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: notes.length,
                              itemBuilder: (BuildContext bct, int index) {
                                Map<String, String> note = notes[index];
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom:
                                          index >= notes.length - 1 ? 0 : 12),
                                  child: Row(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Icon(
                                            note["type"] == "frequency"
                                                ? Icons.schedule_outlined
                                                : Icons.description_outlined,
                                            color: const Color.fromRGBO(
                                                112, 112, 112, 1),
                                          )),
                                      Flexible(
                                        child: TextField(
                                          keyboardType: TextInputType.multiline,
                                          minLines: 1,
                                          maxLines: 2,
                                          controller:
                                              TextEditingController.fromValue(
                                                  TextEditingValue(
                                                      text:
                                                          note['note'] ?? "")),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            // focusedBorder: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 4, horizontal: 4),
                                            isDense: true,
                                            hintStyle: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                            filled: true,
                                            fillColor: Color(0XFFD9D9D9),
                                          ),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            fontFamily: "Inter",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Row(
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        _showDropdown = !_showDropdown;
                                      });
                                    },
                                  ),
                                  Positioned(
                                    top: 40,
                                    left: 0,
                                    child: Visibility(
                                      visible: _showDropdown,
                                      child: SizedBox(
                                        height: 68,
                                        width: 175,
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                DeferPointer(
                                                  child: GestureDetector(
                                                    behavior:
                                                        HitTestBehavior.opaque,
                                                    onTap: () {
                                                      setState(() {
                                                        debugPrint("$notes");
                                                        notes.add({
                                                          "type": "detail",
                                                          "note":
                                                              _newNoteController
                                                                  .value.text,
                                                        });
                                                        _newNoteController
                                                            .clear();
                                                      });
                                                    },
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .description_outlined,
                                                          color: Color.fromRGBO(
                                                              112, 112, 112, 1),
                                                          size: 20,
                                                        ),
                                                        const SizedBox(
                                                            width: 14),
                                                        Text(
                                                          "General Notes",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const Divider(),
                                                DeferPointer(
                                                  child: GestureDetector(
                                                    behavior:
                                                        HitTestBehavior.opaque,
                                                    onTap: () {
                                                      setState(() {
                                                        debugPrint("$notes");
                                                        notes.add({
                                                          "type": "detail",
                                                          "note":
                                                              _newNoteController
                                                                  .value.text,
                                                        });
                                                      });
                                                    },
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .schedule_outlined,
                                                          color: Color.fromRGBO(
                                                              112, 112, 112, 1),
                                                          size: 20,
                                                        ),
                                                        const SizedBox(
                                                            width: 14),
                                                        Text(
                                                          "Day, Time of visits",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Flexible(
                                child: TextField(
                                  controller: _newNoteController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    // focusedBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 4),
                                    isDense: true,
                                    hintStyle: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                    filled: true,
                                    fillColor: Color(0XFFD9D9D9),
                                  ),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    fontFamily: "Inter",
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 14),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 34,
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned(
                                    top: 0,
                                    right: -49,
                                    child: DeferPointer(
                                      child: CircleAvatar(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        child: IconButton(
                                          onPressed: () {
                                            debugPrint("Clicked!");
                                            createSafezone();
                                          },
                                          icon: const Icon(
                                            Icons.done,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor:
                                        const Color.fromRGBO(112, 112, 112, 1),
                                    child: IconButton(
                                      onPressed: () {
                                        int count = 0;
                                        Navigator.popUntil(
                                            context, (route) => count++ == 2);
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
                          )
                        ],
                      ),
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
