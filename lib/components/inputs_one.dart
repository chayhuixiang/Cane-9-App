import 'package:flutter/material.dart';

class InputsOne extends StatelessWidget {
  final String value;
  final double boxwidth;
  final int? howmanylines;
  final double boxheight;
  const InputsOne(
      {super.key,
      required this.value,
      required this.boxwidth,
      required this.boxheight,
      required this.howmanylines});

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
            SizedBox(
              height: boxheight,
              width: boxwidth,
              child: TextField(
                maxLines: howmanylines,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  // focusedBorder: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10.5, horizontal: 4),
                  // isDense: true,
                  hintText: value,
                  hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
                  filled: true,
                  fillColor: Color(0XFFD9D9D9),
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
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
