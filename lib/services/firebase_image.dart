import "package:firebase_storage/firebase_storage.dart";

class FirebaseImage {
  final String? path;
  final storageRef = FirebaseStorage.instance.ref();
  String imageurl = "";

  FirebaseImage(this.path);

  Future fetchUrl() async {
    String? fetchPath = path;
    if (fetchPath != null) {
      Reference ref = storageRef.child(fetchPath);
      imageurl = await ref.getDownloadURL();
    }
  }
}
