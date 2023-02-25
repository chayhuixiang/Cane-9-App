import 'package:cane_9_app/components/cardheaders.dart';
import 'package:flutter/material.dart';

class EditPatientPage extends StatefulWidget {
  const EditPatientPage({super.key});

  @override
  State<EditPatientPage> createState() => _EditPatientPageState();
}

class _EditPatientPageState extends State<EditPatientPage> {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: CardHeaders(title: "Edit Elderly Personal Details"),
        ),
      ),
    ));
  }
}
