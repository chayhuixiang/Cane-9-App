import 'package:flutter/material.dart';

class InputsOne extends StatelessWidget {
  final String title;
  final String value;
  const InputsOne({super.key, required this.title, required this.value});

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
            const SizedBox(
              height: 21,
              width: 143,
              child: TextField(
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  // focusedBorder: InputBorder.none,
                  // contentPadding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                  hintText: 'Name',
                  hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                  filled: true,
                  fillColor: Color(0XFFD9D9D9),
                ),
                // style: TextStyle(
                //   fontWeight: FontWeight.w400,
                //   fontSize: 12,
                //   fontFamily: "Inter",
                // ),
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
