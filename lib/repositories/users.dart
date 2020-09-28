import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:foodApp/model/cart_model.dart';
import 'package:foodApp/model/restaurant_model.dart';
import 'package:foodApp/model/user_model.dart';
// import 'package:foodApp/utils/utils.dart';

class UserRespositories {
  String name;
  String email;
  String password;
  String confirmPassword;
  String restaurantName;
  String imageUrl;
  String description =
      "your hotel description will be here and will be updated from the dashboard";
  final GlobalKey<FormState> registerFormkey = GlobalKey<FormState>();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> restaurantFormkey = GlobalKey<FormState>();

  final StorageReference storageReference =
      FirebaseStorage.instance.ref().child("users");
  final StorageReference storageReferenceRestaurant =
      FirebaseStorage.instance.ref().child("restaurants");
  FirebaseFirestore firestorestance = FirebaseFirestore.instance;
  Users users;

  User user;

  bool currentUserExist() {
    print(FirebaseAuth.instance.currentUser != null);
    print("hhhhhhhhhhhhhhhhhhhhhhhhhhhh");
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<Users> currentUser() async {
    user = FirebaseAuth.instance.currentUser;
    print(user.uid.toString());
    print("iiiiiiiiiiiiiiiiiiii");
    final usersdoc = await firestorestance
        .collection("restaurants")
        .doc(user.uid.toString())
        .get()
        .then((value) => value);
    print(usersdoc.data());
    print(user.uid);
    print("kkkkkkkkkkkkkkkkkkk");
    print(usersdoc.data());
    if (usersdoc.exists) {
      return Users.fromSnapshot(usersdoc);
    }
  }

  Future<Users> createUserAccount(File file, Users user) async {
    if (validatedRegisterAndSaved()) {
      if (password == confirmPassword) {
        User firebaseUser = (await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: email, password: password))
            .user;
        if (firebaseUser.uid != null) {
          user.name = name;
          user.email = email;

          var timeKey = DateTime.now();

          final StorageUploadTask uploadTask =
              storageReference.child(timeKey.toString() + ".jpg").putFile(file);
          var imageUrl =
              await (await uploadTask.onComplete).ref.getDownloadURL();
          user.imageUrl = imageUrl.toString();

          await firestorestance
              .collection("users")
              .doc(firebaseUser.uid.toString())
              .set(user.toMap())
              .then((value) {
            // Users.fromSnapshot();print
            print("jjj");
          });
          await firestorestance
              .collection("users")
              .doc(firebaseUser.uid.toString())
              .get()
              .then((value) {
            users = Users.fromSnapshot(value);
          });
        }
        return users;
      }
    }
    return null;
  }
  // user login application logic

  Future<Users> loginUserAccount() async {
    if (!validatedLoginAndSaved()) return throw Exception("fill the form");

    // var errorMessage;
    User firebaseUser;
    try {
      firebaseUser = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user;
    } on PlatformException catch (e) {
      // print(e.message);
      print(e.toString());
      return throw PlatformException(code: e.message);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      print(e.toString());
      print(e.toString());

      return throw FirebaseAuthException(message: e.message);
    }
    print(firebaseUser.uid.toString() + "eeeeeeeeee");
    DocumentSnapshot docs = await firestorestance
        .collection("users")
        .doc(firebaseUser.uid.toString())
        .get()
        .then((DocumentSnapshot value) {
      print(value.data());
      // return Users.fromSnapshot(value);
      return value;
    });
    // if (docs.exists) {
    return Users.fromSnapshot(docs);
    // }
    // }
    // }
    // return null;
  }

  Future logoutUserAccount() async {
    FirebaseAuth user = FirebaseAuth.instance;
    user.signOut();
  }

  getFullName(String fullname) {
    name = fullname;
  }

  getEmail(String emailAddress) {
    email = emailAddress;
    print(email);
  }

  getPassword(String passwordEnter) {
    password = passwordEnter;
    print(password);
  }

  getConfirmPasword(String confirmePasswordEnter) =>
      confirmPassword = confirmePasswordEnter;

  validateString(String value) {
    if (value.length < 4) {
      return "Field name can't be less than 4 characters";
    }
    return null;
  }

  bool validatedLoginAndSaved() {
    final form = loginFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  bool validatedRegisterAndSaved() {
    final form = registerFormkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // bool isAuthenticatedUser(){
  //   return user != null;
  // }

  ////// restaurant details here//////////////////////////////////////
  ///
  ///
  ///
  ///////////////////////////////////////////////////////////////////
  ///
  ////
  ///////////////////////////////////////////////////////////////////

  Future<Restaurant> submitRestaurantData(
      File file, Restaurant restaurant) async {
    var timeKey = DateTime.now();

    if (validatedRestaurantAndSaved()) {
      User firebaseUser = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password))
          .user;

      if (firebaseUser.uid != null) {
        final StorageUploadTask uploadTask = storageReferenceRestaurant
            .child(timeKey.toString() + ".jpg")
            .putFile(file);
        var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
        restaurant.imageUrl = imageUrl.toString();
        await saveToDatabase(restaurant, firebaseUser.uid.toString());

        //
// DocumentSnapshot docsj = await firestorestance
//           .collection("users")
//           .doc(firebaseUser.uid.toString())
//           .get()
//           .then((DocumentSnapshot value) {
//         print(value.data());
//         // return Users.fromSnapshot(value);
//         return value;
//       });
        //

        print(firebaseUser.uid + "mmmmmmmmmmmmmmmmmmm");
        DocumentSnapshot docs = await firestorestance
            .collection("restaurants")
            .doc(firebaseUser.uid.toString())
            .get()
            .then((DocumentSnapshot value) {
          return value;
        });
        print(docs.data());
        print("chhhhhhhhhhhhhhhhhhhhhhheeeeeeeeccccccccccckkkkkkkkkkk");
        return Restaurant.fromSnapshot(docs);
      }
    }
    // return null;//
  }

  Future saveToDatabase(Restaurant restaurant, String restaurantId) async {
    restaurant.name = name;
    restaurant.email = email;
    restaurant.description = description;

    await firestorestance
        .collection("restaurants")
        .doc(restaurantId)
        .set(restaurant.toMap())
        .then((value) => print("jjjj"));
  }

  getRestuarntName(String fullname) => restaurantName = fullname;

  getDescription(String description) => description = description;

  validateRestaurantString(String value) {
    if (value.length < 4) {
      return "Field name can't be less than 4 characters";
    }
    return null;
  }

  bool validatedRestaurantAndSaved() {
    final form = restaurantFormkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<Restaurant> loginUserRestaurantAccount() async {
    Restaurant restaurant;
    User firebaseUser = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password))
        .user;

    await firestorestance
        .collection("restaurants")
        .doc(firebaseUser.uid.toString())
        .get()
        .then((value) {
      restaurant = Restaurant.fromSnapshot(value);
    });
    return restaurant;
  }

  Future addToCart(Cart cart) async {
    user = FirebaseAuth.instance.currentUser;

    firestorestance.collection("users").doc(user.uid.toString()).update({
      "cart": FieldValue.arrayUnion([cart.toMap()])
    });
  }

  Future removeFromCart(Cart cart) async {
    user = FirebaseAuth.instance.currentUser;
    print("object");
    print(cart.toMap());
    await firestorestance.collection("users").doc(user.uid.toString()).update({
      "cart": FieldValue.arrayRemove([cart.toMap()])
    });
    // print(check);?
    print("object");
  }
}
