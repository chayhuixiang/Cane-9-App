import 'package:flutter/material.dart';

class CardHeaders extends StatelessWidget {
  final String title;
  const CardHeaders({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0XFFF9E3DC),
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 13, 0, 0),
        child: Center(
            child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "Inter",
            fontSize: 12,
          ),
        )),
      ),
    );
  }
}
