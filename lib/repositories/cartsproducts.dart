import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodApp/model/cart_model.dart';

class CartRepository {
  FirebaseFirestore firestorestance = FirebaseFirestore.instance;

  Future<List<Cart>> getAllUserProductsFromDatabase() async {
    User user = FirebaseAuth.instance.currentUser;
    List<Cart> cartsList = List<Cart>();
    try {
      firestorestance.collection("users").snapshots().listen((event) {
        for (DocumentSnapshot prod in event.docs) {
          // productsList.add(Users.fromSnapshot(prod));
          var userIdInDatabase =
              prod.id != null ? prod.id.toString().trim() : "";
          if (user.uid.toString().trim() == userIdInDatabase) {
            var usersCart =
                prod.data()["cart"] != null ? prod.data()["cart"] : null;
            for (Map cart in usersCart) {
              cartsList.add(Cart.fromMap(cart));
            }
          }
        }
      });
    } on FirebaseException catch (e) {
      print(e.message);
    }
    var productData =
        await Future.delayed(const Duration(milliseconds: 500), () {
      return cartsList;
    });
    print(productData[0].imageUrl);
    return productData;
  }

  // Future increaseItem
}
