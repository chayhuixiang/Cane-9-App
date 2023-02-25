import 'package:flutter/material.dart';

class PageHeaders extends StatelessWidget {
  final String title;
  const PageHeaders({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 13, 0, 0),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "Inter",
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
