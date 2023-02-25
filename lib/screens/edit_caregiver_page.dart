import 'package:cane_9_app/components/pageheaders.dart';
import 'package:flutter/material.dart';
import 'package:cane_9_app/components/combine_label_input.dart';
import 'package:cane_9_app/services/firebase_image.dart';

class EditCareGiverPage extends StatefulWidget {
  const EditCareGiverPage({super.key});

  @override
  State<EditCareGiverPage> createState() => _EditCareGiverPageState();
}

class _EditCareGiverPageState extends State<EditCareGiverPage> {
  FirebaseImage caregiverimage =
      FirebaseImage(path: "Caregiver/Caregiver_1.png");

  void fetchimage() async {
    await caregiverimage.fetchUrl();
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: const Color(0XFFF9E3DC),
            child: Column(
              children: [
                const PageHeaders(title: "Edit Caregiver Personal Details"),
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
                                  backgroundImage: caregiverimage.imageurl == ""
                                      ? const AssetImage(
                                              'assets/Caregiver_1.png')
                                          as ImageProvider
                                      : NetworkImage(caregiverimage.imageurl),
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
                                width: 180,
                                child: LableInput(
                                  label: "Name",
                                  boxwidthhere: 143,
                                  boxheighthere: 21,
                                  howmanylineshere: 1,
                                ),
                              ),
                              SizedBox(
                                width: 140,
                                child: LableInput(
                                  label: "Relationship",
                                  boxwidthhere: 95,
                                  boxheighthere: 21,
                                  howmanylineshere: 1,
                                ),
                              ),
                            ],
                          ),
                          const LableInput(
                            label: "Contact Number",
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
