import 'package:cane_9_app/components/pageheaders.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:cane_9_app/components/label_input_combined.dart';
import 'package:cane_9_app/services/firebase_image.dart';
import 'package:cane_9_app/constants.dart';

class EditPatientPage extends StatefulWidget {
  const EditPatientPage({super.key});

  @override
  State<EditPatientPage> createState() => _EditPatientPageState();
}

class _EditPatientPageState extends State<EditPatientPage> {
  FirebaseImage caregiverimage =
      FirebaseImage(path: "Caregiver/Caregiver_1.png");
  FirebaseImage patientimage = FirebaseImage(path: "Patient/Patient_1.png");

  Future<http.Response> fetchAlbum() {
    return http.get(Uri.parse('$apiurl/patient/read'));
  }

  void fetchimage() async {
    await caregiverimage.fetchUrl();
    await patientimage.fetchUrl();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchimage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              children: [
                const PageHeaders(title: "Edit Elderly Personal Details"),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 18, 0, 0),
                                child: SizedBox(
                                  width: 300,
                                  child: Text(
                                    "Please note that information saved here will be accessible to any passers-by who scans the QR code on the cane.",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 5,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      fontFamily: "Inter",
                                      height: 1.25,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                                child: CircleAvatar(
                                  backgroundImage: patientimage.imageurl == ""
                                      ? const AssetImage('assets/Patient_1.png')
                                          as ImageProvider
                                      : NetworkImage(patientimage.imageurl),
                                  radius: 86,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 12,
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
                          Row(
                            children: const [
                              SizedBox(
                                width: 250,
                                child: LabelInputCombined(
                                  label: "Name",
                                  boxwidthhere: 143,
                                  boxheighthere: 21,
                                  howmanylineshere: 1,
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: LabelInputCombined(
                                  label: "Age",
                                  boxwidthhere: 40,
                                  boxheighthere: 21,
                                  howmanylineshere: 1,
                                ),
                              ),
                            ],
                          ),
                          const LabelInputCombined(
                            label: "Address",
                            boxwidthhere: 231,
                            boxheighthere: 50,
                            howmanylineshere: 2,
                          ),
                          const LabelInputCombined(
                            label: "Postal Code",
                            boxwidthhere: 143,
                            boxheighthere: 21,
                            howmanylineshere: 1,
                          ),
                          const LabelInputCombined(
                            label: "Languages",
                            boxwidthhere: 143,
                            boxheighthere: 21,
                            howmanylineshere: 1,
                          ),
                          const LabelInputCombined(
                            label: "Likes, Hobbies",
                            boxwidthhere: 143,
                            boxheighthere: 21,
                            howmanylineshere: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 9, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 9, 0),
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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
