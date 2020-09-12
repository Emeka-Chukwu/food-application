import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodApp/model/product_model.dart';

class ProductRespositories {
  String name;
  String imageUrl;
  String categoryName;
  String resturantName;
  String description;
  String price;

  String userId;

  final GlobalKey<FormState> productFormkey = GlobalKey<FormState>();

  final FirebaseAuth restaurant = FirebaseAuth.instance;

  final StorageReference storageReference =
      FirebaseStorage.instance.ref().child("products");
  FirebaseFirestore firestorestance = FirebaseFirestore.instance;

  Future submitProductData(File file, Product product) async {
    var timeKey = DateTime.now();

    if (validatedProductAndSaved()) {
      final StorageUploadTask uploadTask =
          storageReference.child(timeKey.toString() + ".jpg").putFile(file);
      var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      product.imageUrl = imageUrl.toString();
      saveToDatabase(product);

      return imageUrl.toString();
    }
    // return "fill the form correctly";
  }

  Future saveToDatabase(Product product) async {
    product.name = name;
    product.description = description;
    product.categoryName = categoryName;
    print(price);
    print(price);
    print("price");
    print(price);

    print("price");

    print(price);

    product.price = price;
    userId = restaurant.currentUser.uid.toString();
    print(userId);
    await FirebaseFirestore.instance
        .collection("restaurants")
        .doc(userId)
        .get()
        .then((value) {
      print(value.data());

      return product.restaurantName = value.data()["name"];
    });
    product.restuarantId = userId;
    firestorestance
        .collection("products")
        .add(product.toMap())
        .then((value) => print(value));
  }

  getFullName(String fullname) {
    name = fullname;
    print(name);
  }

  getDescription(String descriptionhere) {
    description = descriptionhere;
    print(description);
  }

  getCategoryName(String categoryName) {
    categoryName = categoryName;
    print(categoryName);
  }

  getPrice(String priceCategory) {
    price = priceCategory;
    print(price);
  }

  validateString(String value) {
    if (value.length < 4) {
      return "Field name can't be less than 4 characters";
    }
    return null;
  }

  bool validatedProductAndSaved() {
    final form = productFormkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<List<Product>> getAllProductsFromDatabase() async {
    List<Product> productsList = List<Product>();

    firestorestance.collection("products").snapshots().listen((event) {
      for (DocumentSnapshot prod in event.docs) {
        productsList.add(Product.fromSnapshot(prod));
      }
    });
    var productData =
        await Future.delayed(const Duration(milliseconds: 500), () {
      return productsList;
    });

    return productData;
  }

  Future deleteProduct(String id) async {
    await firestorestance
        .collection("products")
        .doc(id)
        .delete()
        .then((_) => print("success"));
  }

  Future updateProduct(String id) async {
    await firestorestance
        .collection("products")
        .doc(id)
        .delete()
        .then((value) => print("deleted"));
  }
}
