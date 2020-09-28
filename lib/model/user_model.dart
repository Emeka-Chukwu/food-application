import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodApp/model/cart_model.dart';

class Users {
  String id;
  String name;
  String email;
  String password;
  String stripeId;
  double priceSum = 0;
  int quantitySum = 0;
  List<Cart> cart;
  String imageUrl;

  Users(
      {this.id,
      this.name,
      this.email,
      this.stripeId,
      this.priceSum,
      this.quantitySum,
      this.password,
      this.imageUrl,
      this.cart});

  Users.fromSnapshot(DocumentSnapshot snapshot) {
    // id = snapshot.data() != null ? snapshot.id : null;
    id = snapshot.data() != null ? snapshot.id.toString() : null;
    name = snapshot.data() != null ? snapshot.data()["name"] : null;
    email = snapshot.data() != null ? snapshot.data()["email"] : null;
    stripeId = snapshot.data() != null ? snapshot.data()["stripeId"] : null;
    priceSum = snapshot.data()["cart"] == null
        ? 0
        : getTotalPrice(cart: snapshot.data()["cart"]);
    cart = snapshot.data()["cart"] != null
        ? convertCartItems(snapshot.data()["cart"])
        : [];
    // if (snapshot.data()["cart"] != null) {
    //   cart = List<Cart>();
    //   snapshot.data()["cart"].forEach((Map<String, dynamic> tojson) {
    //     cart.add(Cart.fromMap(tojson));
    //   });
    // }
  }
  // Map cartItem in cart)
  Map<String, dynamic> toMap() => {
        "name": this.name,
        "email": this.email,
        "stripeId": this.stripeId,
      };

  double getTotalPrice({List cart}) {
    if (cart == null) return 0;

    for (Map cartItem in cart) {
      priceSum += ["price"] != null
          ? int.parse(cartItem["price"])
          : 10 * cartItem["quantity"];
    }
    return priceSum;
  }

  List<Cart> convertCartItems(List cart) {
    List<Cart> convertedCarts = [];
    for (Map cartItem in cart) {
      convertedCarts.add(Cart.fromMap(cartItem));
    }
    return convertedCarts;
  }
}
