import "package:firebase_storage/firebase_storage.dart";

class Safezone {
  final String? name;
  final String? address;
  final String? path;
  final storageRef = FirebaseStorage.instance.ref();

  String url = "";

  Safezone(this.name, this.address, this.path);

  Future fetchUrl() async {
    String? fetchPath = path;
    if (fetchPath != null) {
      Reference ref = storageRef.child(fetchPath);
      url = await ref.getDownloadURL();
    }
  }
}
