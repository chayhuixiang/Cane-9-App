import 'package:cane_9_app/components/edit_button.dart';
import 'package:cane_9_app/components/labels_one.dart';
import 'package:cane_9_app/components/labels_two.dart';
import 'package:cane_9_app/screens/edit_patient_page.dart';
import 'package:flutter/material.dart';
import 'package:cane_9_app/services/firebase_image.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  FirebaseImage caregiverimage = FirebaseImage("Caregiver/Caregiver_1.png");
  FirebaseImage patientimage = FirebaseImage("Patient/Patient_1.png");

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
                  height: 550,
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
                        const LabelsTwo(
                            title: "Name",
                            value: "Mr Wilson Huang",
                            title2: "Age",
                            value2: "74"),
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
                  height: 420,
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
                                onPressed: () {},
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
