import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:foodApp/model/restaurant_model.dart';
import 'package:foodApp/repositories/restaurantrespository.dart';
import 'package:foodApp/screen/restaurants.dart';
import 'package:foodApp/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  RestaurantRespositories restaurantRespositories;
  RestaurantCubit({this.restaurantRespositories}) : super(RestaurantInitial());

  File imagePath;
  Future<void> getRestuarantsList(BuildContext context) async {
    try {
      emit(RestaurantLoading());
      final restaurants =
          await restaurantRespositories.getAllRestaurantsFromDatabase();
      print(restaurants);
      print("here in cubit");
      emit(RestaurantLoaded(restaurants));

      changeScreen(context, RestaurantsScreen());
    } on FirebaseException catch (e) {
      emit(RestaurantError(e.toString()));
    }
  }

  Future<void> getImage() async {
    final picker = ImagePicker();
    var image = await picker.getImage(source: ImageSource.gallery);
    File compressedFile = await FlutterNativeImage.compressImage(image.path,
        quality: 95, targetHeight: 450, targetWidth: 450);
    imagePath = compressedFile;
    emit(RestaurantAuthenticatedPicture(imagePath));
  }
}
