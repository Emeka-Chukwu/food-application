// import 'package:bloc/bloc.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:foodApp/model/product_model.dart';
import 'package:foodApp/repositories/productsrepository.dart';
import 'package:foodApp/screen/products.dart';
import 'package:foodApp/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductRespositories productRespositories;
  ProductsCubit(this.productRespositories) : super(ProductsInitial());
  var imagePath;
  Product product = Product();

  Future<void> getImage() async {
    final picker = ImagePicker();
    var image = await picker.getImage(source: ImageSource.gallery);
    File compressedFile = await FlutterNativeImage.compressImage(image.path,
        quality: 95, targetHeight: 450, targetWidth: 450);
    imagePath = compressedFile;
    emit(GetProductImageFrom(imagePath));
  }

  Future<void> uploadDatatoFirestore(BuildContext context) async {
    try {
      await productRespositories.submitProductData(imagePath, product);
      changeScreen(context, ProductsScreen());
    } on FirebaseException catch (err) {
      emit(ProductError(message: err.code));
    }
  }

  Future<void> getAllProducts(BuildContext context) async {
    try {
      emit(ProductLoading());
      final productsList =
          await productRespositories.getAllProductsFromDatabase();
      emit(ProductLoaded(products: productsList));
      changeScreen(context, ProductsScreen());
    } on FirebaseException catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }
}
