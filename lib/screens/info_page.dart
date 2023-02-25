import 'package:cane_9_app/components/edit_button.dart';
import 'package:cane_9_app/components/labels_one.dart';
import 'package:cane_9_app/components/labels_two.dart';
import 'package:cane_9_app/screens/edit_caregiver_page.dart';
import 'package:cane_9_app/screens/edit_patient_page.dart';
import 'package:flutter/material.dart';
import 'package:cane_9_app/services/firebase_image.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:cane_9_app/constants.dart';
import 'package:cane_9_app/services/album_from_json.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late Future<Album> futureAlbum;
  String name = '';
  double age = 0;
  FirebaseImage caregiverimage =
      FirebaseImage(path: "Caregiver/Caregiver_1.png");
  FirebaseImage patientimage = FirebaseImage(path: "Patient/Patient_1.png");

  Future<Album> fetchAlbum() async {
    final response = await http.get(Uri.parse('$apiurl/patient/read'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
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
    futureAlbum = fetchAlbum();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FutureBuilder<Album>(
      future: futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          name = snapshot.data!.name;
          // age = snapshot.data!.age;
          return const Text("yay");
        } else {
          return const Text("FUck");
        }
      },
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0XFFF9E3DC),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 13, 0, 0),
                child: const Center(
                    child: Text(
                  "Personal Details",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inter",
                    fontSize: 12,
                  ),
                )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
                  height: 500,
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(18, 8, 0, 0),
                              child: Text(
                                "Elderly Personal Details    ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  fontFamily: "Inter",
                                  height: 1.25,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.info,
                              size: 15,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 10, 0),
                              child: EditButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return const EditPatientPage();
                                      },
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
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
                        LabelsTwo(
                          title: "Name",
                          value: name,
                          title2: "Age",
                          value2: age.toString(),
                        ),
                        const LabelsOne(
                          title: "Address",
                          value:
                              "623 Jurong West Street 61, Block 623, #06-019",
                        ),
                        const LabelsOne(
                            title: "Postal Code", value: "Singapore 640623"),
                        const LabelsOne(
                            title: "Languages", value: "Hokkien, Mandarian"),
                        const LabelsOne(
                            title: "Likes, Hobbies", value: "Mahjong, Karoke"),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 34),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
                  height: 380,
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(18, 8, 0, 0),
                              child: Text(
                                "Caregiver/Next-of-kin Details    ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  fontFamily: "Inter",
                                  height: 1.25,
                                ),
                              ),
                            ),
                            Icon(Icons.info,
                                size: 15,
                                color: Theme.of(context).colorScheme.primary),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 10, 0),
                              child: EditButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return const EditCareGiverPage();
                                      },
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                          child: CircleAvatar(
                            backgroundImage: caregiverimage.imageurl == ""
                                ? const AssetImage('assets/Caregiver_1.png')
                                    as ImageProvider
                                : NetworkImage(caregiverimage.imageurl),
                            radius: 86,
                          ),
                        ),
                        const LabelsTwo(
                          title: "Name",
                          value: "Ms Lynn Lee",
                          title2: "Relationship",
                          value2: "Daughter",
                        ),
                        const LabelsOne(
                            title: "Contact Number", value: "91234567"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
