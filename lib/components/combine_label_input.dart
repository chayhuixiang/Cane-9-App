import 'package:flutter/material.dart';
import 'package:cane_9_app/components/inputs_one.dart';
import 'package:cane_9_app/components/label_title.dart';

class LableInput extends StatelessWidget {
  final String label;
  final double boxwidthhere;
  final int? howmanylineshere;
  final double boxheighthere;
  const LableInput(
      {super.key,
      required this.label,
      required this.boxwidthhere,
      required this.boxheighthere,
      required this.howmanylineshere});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(29, 8, 0, 0),
          child: LabelTitle(label),
        ),
        InputsOne(
          value: label,
          boxwidth: boxwidthhere,
          boxheight: boxheighthere,
          howmanylines: howmanylineshere,
        ),
      ],
    );
  }
}
