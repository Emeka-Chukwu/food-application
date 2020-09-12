import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodApp/model/restaurant_model.dart';

class RestaurantRespositories {
  final FirebaseAuth restaurant = FirebaseAuth.instance;

  FirebaseFirestore firestorestance = FirebaseFirestore.instance;

  Future<List<Restaurant>> getAllRestaurantsFromDatabase() async {
    List<Restaurant> restuarantsList = List<Restaurant>();

    firestorestance.collection("restaurants").snapshots().listen((event) {
      for (DocumentSnapshot prod in event.docs) {
        restuarantsList.add(Restaurant.fromSnapshot(prod));
      }
    });

    var resdata = await Future.delayed(const Duration(milliseconds: 500), () {
      print("inside the delayed");
      print(restuarantsList[0].email);
      print("inside the delayed");
      return restuarantsList;
    });
    print("printed restaurants list");
    // return restuarantsList;
    print(resdata);
    return resdata;
  }

  Future deleteRestaurant(String id) async {
    await firestorestance
        .collection("restaurants")
        .doc(id)
        .delete()
        .then((_) => print("success"));
  }

  Future updateRestaurant(String id) async {
    await firestorestance
        .collection("restaurants")
        .doc(id)
        .delete()
        .then((value) => print("deleted"));
  }
}
