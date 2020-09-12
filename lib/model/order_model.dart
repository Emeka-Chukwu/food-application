import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  String id;
  String restaurantId;
  String description;
  String status;
  String userId;
  int createdAt;
  double total;
  List cart;

  Order.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot.id.toString();
    restaurantId = snapshot.data()["restaurantId"];
    description = snapshot.data()["description"];
    status = snapshot.data()["status"];
    userId = snapshot.data()["userId"];
    createdAt = snapshot.data()["createdAt"];
    cart = snapshot.data()["cart"];
  }
}
