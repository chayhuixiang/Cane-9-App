import 'package:flutter/material.dart';
import "package:firebase_storage/firebase_storage.dart";

class CareGiverInfo {
  final String id;
  final String name;
  final String relationship;
  final String contact;
  final String path;

  final storageRef = FirebaseStorage.instance.ref();
  String url = '';

  CareGiverInfo({
    required this.id,
    required this.name,
    required this.relationship,
    required this.contact,
    required this.path,
  });

  factory CareGiverInfo.fromJson(Map<String, dynamic> json) {
    return CareGiverInfo(
      id: json['id'],
      name: json['name'],
      relationship: json['relationship'],
      contact: json['contact'],
      path: json['image'],
    );
  }
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
