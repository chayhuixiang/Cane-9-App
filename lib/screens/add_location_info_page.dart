import 'package:cane_9_app/components/label_title.dart';
import 'package:cane_9_app/components/pageheaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cane_9_app/services/firebase_image.dart';
import 'package:cane_9_app/components/label_input_combined_expanded.dart';
import 'dart:io';

class AddLocationInfoPage extends StatefulWidget {
  const AddLocationInfoPage({super.key, required this.placemark});
  final Placemark placemark;

  @override
  State<AddLocationInfoPage> createState() => _AddLocationInfoPageState();
}

class _AddLocationInfoPageState extends State<AddLocationInfoPage> {
  String? _safezoneRadius;
  final ImagePicker _picker = ImagePicker();
  ImageProvider<Object>? _safezoneImage =
      const AssetImage('assets/Placeholder.png');

  @override
  Widget build(BuildContext context) {
    const List<String> list = <String>["One", "Two", "Three"];

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
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const SizedBox(width: 3),
                            SizedBox(
                              width: 40,
                              height: 24,
                              child: DropdownButton(
                                hint: null,
                                value: list.first,
                                items: list.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Icon(Icons.add),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  debugPrint(value);
                                },
                                iconSize: 0,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Flexible(
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
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
                                style: TextStyle(
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
                                        int count = 0;
                                        Navigator.popUntil(
                                            context, (route) => count++ == 2);
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
          ],
        )),
      ),
    );
  }
}
