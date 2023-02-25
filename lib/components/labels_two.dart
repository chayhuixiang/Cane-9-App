import 'package:flutter/material.dart';

class LabelsTwo extends StatelessWidget {
  final String title;
  final String value;
  final String title2;
  final String value2;
  const LabelsTwo(
      {super.key,
      required this.title,
      required this.value,
      required this.title2,
      required this.value2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 14, 0, 0),
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
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
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
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 79, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title2),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Text(value2,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      fontFamily: "Inter",
                    )),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
