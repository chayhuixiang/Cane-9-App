import 'package:cane_9_app/components/pageheaders.dart';
import 'package:flutter/material.dart';
import 'package:cane_9_app/components/edit_button.dart';
import 'package:cane_9_app/components/label_input_combined.dart';
import 'package:cane_9_app/services/firebase_image.dart';

class EditPatientPage extends StatefulWidget {
  const EditPatientPage({super.key});

  @override
  State<EditPatientPage> createState() => _EditPatientPageState();
}

class _EditPatientPageState extends State<EditPatientPage> {
  FirebaseImage caregiverimage =
      FirebaseImage(path: "Caregiver/Caregiver_1.png");
  FirebaseImage patientimage = FirebaseImage(path: "Patient/Patient_1.png");

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
                    height: 650,
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
                              const Icon(
                                Icons.info,
                                size: 15,
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
                              radius: 113,
                            ),
                          ),
                          const LabelInputCombined(
                            label: "Name",
                            boxwidthhere: 143,
                            boxheighthere: 21,
                            howmanylineshere: 1,
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
