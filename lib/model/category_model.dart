import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String id;
  String name;
  String imageUrl;

  Category.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot.id != null ? snapshot.id.toString() : null;
    name = snapshot.data()["name"] ? snapshot.data()["name"] : null;
    imageUrl = snapshot.data()["imageUrl"] != null
        ? snapshot.data()["imageUrl"]
        : null;
  }

  Map<String, dynamic> toMap() =>
      {"name": this.name, "imageUrl": this.imageUrl};
}
