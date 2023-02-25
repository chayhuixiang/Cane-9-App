import "dart:io";
import "package:firebase_storage/firebase_storage.dart";
import 'package:path/path.dart';
import 'package:flutter/material.dart';

class FirebaseImage {
  final String? path;
  final Reference storageRef = FirebaseStorage.instance.ref();
  String imageurl = "";

  FirebaseImage({this.path});

  Future uploadImage(File f, String prefix) async {
    String fileName = basename(f.path);
    final destination = '$prefix/$fileName';

    try {
      final ref = storageRef.child(destination);
      await ref.putFile(f);
    } catch (e) {
      debugPrint("$e");
    }
  }

  Future fetchUrl() async {
    String? fetchPath = path;
    if (fetchPath != null) {
      Reference ref = storageRef.child(fetchPath);
      imageurl = await ref.getDownloadURL();
    }
  }
}
