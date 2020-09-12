import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodApp/model/user_model.dart';

class Restaurant {
  String id;
  String name;
  String email;
  List<Users> usersLike;
  String description;
  String imageUrl;
  int rating;
  int popular;

  Restaurant(
      {this.id,
      this.name,
      this.usersLike,
      this.imageUrl,
      this.description,
      this.email,
      this.rating = 1,
      this.popular = 0});

  Restaurant.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot.id != null ? snapshot.id.toString() : null;
    name = snapshot.data()["name"] != null ? snapshot.data()["name"] : null;
    email = snapshot.data()["email"] != null
        ? snapshot.data()["email"]
        : "example@gmail.com";
    imageUrl = snapshot.data()["imageUrl"] != null
        ? snapshot.data()["imageUrl"]
        : null;
    rating =
        snapshot.data()["rating"] != null ? snapshot.data()["rating"] : null;
    usersLike = snapshot.data()["userLike"] != null
        ? snapshot.data()["userLike"]
        : null;
    popular =
        snapshot.data()['popular'] != null ? snapshot.data()["popular"] : null;
    description = snapshot.data()["description"] != null
        ? snapshot.data()["description"]
        : null;
  }

  Map<String, dynamic> toMap() => {
        "name": this.name,
        "email": this.email,
        "imageUrl": this.imageUrl,
        "rating": this.rating,
        "usersLike": this.usersLike,
        "popular": this.popular,
        "description": this.description
      };
}
