import "package:firebase_storage/firebase_storage.dart";
import 'package:flutter/material.dart';

class Safezone {
  final String? id;
  final String? name;
  final String? address;
  final String? path;
  final String? postal;
  final int? radius;
  final List<String>? frequencies;
  final List<String>? details;

  final storageRef = FirebaseStorage.instance.ref();

  String url = "";

  Safezone(
      {required this.id,
      required this.name,
      required this.address,
      required this.path,
      required this.postal,
      required this.radius,
      required this.frequencies,
      required this.details});

  Future fetchUrl() async {
    String? fetchPath = path;
    try {
      if (fetchPath != null) {
        Reference ref = storageRef.child(fetchPath);
        url = await ref.getDownloadURL();
      }
    } catch (e) {
      debugPrint("$e");
    }
  }
}
