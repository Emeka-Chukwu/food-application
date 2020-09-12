import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodApp/model/user_model.dart';

class Product {
  String id;
  String name;
  int rating;
  String imageUrl;
  String restuarantId;
  String restaurantName;
  String description;
  String categoryName;
  String price;

  List<Users> userlikes;

  Product(
      {this.name,
      this.rating = 0,
      this.imageUrl,
      this.restuarantId,
      this.description,
      this.categoryName,
      this.restaurantName,
      this.price,
      this.userlikes});

  Product.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot.id.toString() != null ? snapshot.id.toString() : null;
    name = snapshot.data()["name"] != null ? snapshot.data()["name"] : null;
    price = snapshot.data()["price"] != null ? snapshot.data()["price"] : null;
    rating =
        snapshot.data()["rating"] != null ? snapshot.data()["rating"] : null;
    imageUrl = snapshot.data()["imageUrl"] != null
        ? snapshot.data()["imageUrl"]
        : null;
    restuarantId = snapshot.data()["restaurantId"] != null
        ? snapshot.data()["restaurantId"]
        : null;
    description = snapshot.data()["description"] != null
        ? snapshot.data()["description"]
        : null;
    categoryName = snapshot.data()["catergory"] != null
        ? snapshot.data()["catergory"]
        : null;
    restaurantName = snapshot.data()["restaurantName"] != null
        ? snapshot.data()["restaurantName"]
        : null;
    // rates = snapshot.data()["rate"];
    userlikes = snapshot.data()["userlikes"] == null
        ? []
        : snapshot.data()["userlikes"];
  }

  Map<String, dynamic> toMap() => {
        "id": this.id,
        "name": this.name,
        "price": this.price,
        "rating": this.rating,
        "imageUrl": this.imageUrl,
        "restaurantId": this.restuarantId,
        "restaurantName": this.restaurantName,
        "description": this.description,
        "categoryId": this.categoryName,
        // "rates": this.rates,
        "userlikes": this.userlikes,
        "restaurant": this.restaurantName
      };
}
