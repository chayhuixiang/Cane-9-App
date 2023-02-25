import "package:firebase_storage/firebase_storage.dart";

class Safezone {
  final String? name;
  final String? address;
  final String? path;
  final String? postal;
  final String? radius;
  final List<String>? frequencies;
  final List<String>? details;

  final storageRef = FirebaseStorage.instance.ref();

  String url = "";

  Safezone(this.name, this.address, this.path, this.postal, this.radius,
      this.frequencies, this.details);

  Future fetchUrl() async {
    String? fetchPath = path;
    if (fetchPath != null) {
      Reference ref = storageRef.child(fetchPath);
      url = await ref.getDownloadURL();
    }
  }
}
