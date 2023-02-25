// ignore_for_file: no_logic_in_create_state

import 'package:cane_9_app/components/label_title.dart';
import 'package:cane_9_app/components/pageheaders.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cane_9_app/services/firebase_image.dart';
import 'package:cane_9_app/components/label_input_combined_expanded.dart';
import 'package:cane_9_app/services/safezone.dart';
import 'dart:io';

class EditLocationInfoPage extends StatefulWidget {
  final Safezone sz;

  const EditLocationInfoPage({super.key, required this.sz});

  @override
  State<EditLocationInfoPage> createState() => _EditLocationInfoPageState(
        name: sz.name,
        postal: sz.postal,
        radius: sz.radius,
        image: sz.url,
        address: sz.address,
        frequencies: sz.frequencies,
        details: sz.details,
      );
}

class _EditLocationInfoPageState extends State<EditLocationInfoPage> {
  final ImagePicker _picker = ImagePicker();

  String? name;
  String? postal;
  String? radius;
  String? address;
  String? image;
  List<Map<String, String>> notes = [];

  bool _showDropdown = false;

  final TextEditingController _newNoteController = TextEditingController();
  late final TextEditingController _nameController =
      TextEditingController.fromValue(TextEditingValue(text: name ?? "-"));
  late final TextEditingController _addressController =
      TextEditingController.fromValue(TextEditingValue(text: address ?? "-"));
  late final TextEditingController _postalController =
      TextEditingController.fromValue(TextEditingValue(text: postal ?? "-"));

  _EditLocationInfoPageState({
    required this.name,
    required this.postal,
    required this.radius,
    required this.address,
    required this.image,
    required List<String>? frequencies,
    required List<String>? details,
  }) {
    List<Map<String, String>>? frequencyNotes = frequencies?.map((frequency) {
      return {"type": "frequency", "note": frequency};
    }).toList();
    List<Map<String, String>>? detailNotes = details?.map((detail) {
      return {"type": "detail", "note": detail};
    }).toList();
    notes = [...(frequencyNotes ?? []), ...(detailNotes ?? [])];
  }

  late ImageProvider<Object> _safezoneImage = (image == "" || image == null)
      ? const AssetImage('assets/Placeholder.png') as ImageProvider
      : NetworkImage(image!);

  void fetchUrl() async {}

  @override
  void initState() {
    super.initState();
    fetchUrl();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _addressController.dispose();
    _postalController.dispose();
    _newNoteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            const PageHeaders(title: "Edit Location"),
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
                      mainAxisSize: MainAxisSize.min,
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
                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                          spreadRadius: 4),
                                    ]),
                                child: GestureDetector(
                                  onTap: () async {
                                    final XFile? selectedImage = await _picker
                                        .pickImage(source: ImageSource.gallery);
                                    if (selectedImage != null) {
                                      FirebaseImage fi = FirebaseImage();
                                      final File imageFile =
                                          File(selectedImage.path);
                                      await fi.uploadImage(
                                          imageFile, 'Safezone/');

                                      setState(() {
                                        _safezoneImage = FileImage(imageFile);
                                      });
                                    }
                                  },
                                  child: CircleAvatar(
                                    radius: 17,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.tertiary,
                                    child: const Icon(Icons.add,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        // LabelInputCombinedExpanded(
                        //   value: "Hougang",
                        //   hintText: "Name of Place",
                        //   height: 21,
                        //   maxLines: 1,
                        //   controller: TextEditingController(),
                        // ),
                        LabelInputCombinedExpanded(
                            hintText: "Name of Place",
                            height: 21,
                            maxLines: 1,
                            controller: _nameController),
                        const SizedBox(height: 7),
                        LabelInputCombinedExpanded(
                            hintText: "Address",
                            height: 21,
                            maxLines: 2,
                            controller: _addressController),
                        const SizedBox(height: 7),
                        LabelInputCombinedExpanded(
                            hintText: "Postal Code",
                            height: 21,
                            maxLines: 1,
                            controller: _postalController),
                        const SizedBox(height: 7),
                        const LabelTitle("Set Safe Zone Radius"),
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
                                      groupValue: radius,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: const VisualDensity(
                                        horizontal:
                                            VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity,
                                      ),
                                      onChanged: (String? value) {
                                        setState(() => radius = value);
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
                                      groupValue: radius,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: const VisualDensity(
                                        horizontal:
                                            VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity,
                                      ),
                                      onChanged: (String? value) {
                                        setState(() => radius = value);
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
                                      groupValue: radius,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: const VisualDensity(
                                        horizontal:
                                            VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity,
                                      ),
                                      onChanged: (String? value) {
                                        setState(() => radius = value);
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
                                    bottom: index >= notes.length - 1 ? 0 : 12),
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
                                                    text: note['note'] ?? "")),
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
                                            children: [
                                              GestureDetector(
                                                behavior:
                                                    HitTestBehavior.opaque,
                                                onTap: () {
                                                  setState(() {
                                                    debugPrint("$notes");
                                                    notes.add({
                                                      "type": "detail",
                                                      "note": _newNoteController
                                                          .value.text,
                                                    });
                                                  });
                                                },
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .description_outlined,
                                                      color: Color.fromRGBO(
                                                          112, 112, 112, 1),
                                                      size: 20,
                                                    ),
                                                    const SizedBox(width: 14),
                                                    Text(
                                                      "General Notes",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Divider(),
                                              GestureDetector(
                                                behavior:
                                                    HitTestBehavior.opaque,
                                                onTap: () {
                                                  setState(() {
                                                    debugPrint("$notes");
                                                    notes.add({
                                                      "type": "detail",
                                                      "note": _newNoteController
                                                          .value.text,
                                                    });
                                                  });
                                                },
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                      Icons.schedule_outlined,
                                                      color: Color.fromRGBO(
                                                          112, 112, 112, 1),
                                                      size: 20,
                                                    ),
                                                    const SizedBox(width: 14),
                                                    Text(
                                                      "Day, Time of visits",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall,
                                                    ),
                                                  ],
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
                                keyboardType: TextInputType.multiline,
                                controller: _newNoteController,
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
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.done,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor:
                                      const Color.fromRGBO(112, 112, 112, 1),
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
