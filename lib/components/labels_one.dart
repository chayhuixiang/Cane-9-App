import 'package:flutter/material.dart';

class LabelsOne extends StatelessWidget {
  final String title;
  final String value;
  const LabelsOne({super.key, required this.title, required this.value});

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 8, 0, 0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                fontFamily: "Inter",
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  fontFamily: "Inter",
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
