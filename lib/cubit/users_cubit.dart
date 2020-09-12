import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:foodApp/model/restaurant_model.dart';
import 'package:foodApp/model/user_model.dart';
import 'package:foodApp/repositories/users.dart';
import 'package:foodApp/screen/welcome_auth.dart';
import 'package:foodApp/screen/welcome_unAuth.dart';
import 'package:foodApp/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final UserRespositories userRespositories;
  Users users = Users();
  var userDetails;
  Restaurant restaurant = Restaurant();
  File imagePath;
  File imagePathRestaurant;
  UsersCubit({this.userRespositories}) : super(UsersInitial());

  // Future<void> getImage() async {
  //   userRespositories.getImage();
  //   print(userRespositories.imagePath);
  //   // imagePath = userRespositories.getImage();
  //   // final picker = ImagePicker();
  //   // var image = await picker.getImage(source: ImageSource.gallery);
  //   // File compressedFile = await FlutterNativeImage.compressImage(image.path,
  //   // quality: 80, targetHeight: 450, targetWidth: 450);

  //   // imagePath = File(image.path);
  // }

  Future<void> getImage() async {
    final picker = ImagePicker();
    var image = await picker.getImage(source: ImageSource.gallery);
    File compressedFile = await FlutterNativeImage.compressImage(image.path,
        quality: 95, targetHeight: 450, targetWidth: 450);
    imagePath = compressedFile;

    emit(UserAuthenticatedPicture(imagePath));
    print(imagePath);
  }

  Future<void> getRestaurantImage() async {
    final picker = ImagePicker();
    var image = await picker.getImage(source: ImageSource.gallery);
    File compressedFile = await FlutterNativeImage.compressImage(image.path,
        quality: 95, targetHeight: 450, targetWidth: 450);
    imagePathRestaurant = compressedFile;
    emit(UserAuthenticatedPicture(imagePathRestaurant));
  }

  Future<void> registerUser() async {
    try {
      UserAuthenticating();
      final user = await userRespositories.createUserAccount(imagePath, users);
      emit(NormalUserAuthenticated(user));
    } on FirebaseException catch (e) {
      if (e.code == "weak-password") {
        emit(UserAuthenticatedError("password provided is too weak"));
      } else if (e.code == "email-already-in-use") {
        emit(UserAuthenticatedError("Email exist in database"));
      } else {
        emit(UserAuthenticatedError(e.code.toString()));
      }
    }
  }

  Future<void> loginUser(BuildContext context) async {
    try {
      UserAuthenticating();
      final user = await userRespositories.loginUserAccount();
      emit(NormalUserAuthenticated(user));
      changeScreen(context, WelcomeAuth());
    } on FirebaseException catch (e) {
      if (e.code == "user-not-found") {
        emit(UserAuthenticatedError("Wrong email"));
      } else if (e.code == "wrong-password") {
        emit(UserAuthenticatedError("wrong password"));
      } else {
        emit(UserAuthenticatedError(e.code.toString()));
      }
    }
  }

  Future<void> registerRestaurantUser() async {
    try {
      UserAuthenticating();
      final user = await userRespositories.submitRestaurantData(
          imagePathRestaurant, restaurant);
      emit(RestaurantUserAuthenticated(user));
    } on FirebaseException catch (e) {
      if (e.code == "weak-password") {
        emit(UserAuthenticatedError("password provided is too weak"));
      } else if (e.code == "email-already-in-use") {
        emit(UserAuthenticatedError("Email exist in database"));
      } else {
        emit(UserAuthenticatedError(e.code.toString()));
      }
    }
  }

  Future<void> loginRestaurantUser(BuildContext context) async {
    try {
      UserAuthenticating();
      final user = await userRespositories.loginUserRestaurantAccount();
      emit(RestaurantUserAuthenticated(user));
      changeScreen(context, WelcomeAuth());
    } on FirebaseException catch (e) {
      if (e.code == "user-not-found") {
        emit(UserAuthenticatedError("Wrong email"));
      } else if (e.code == "wrong-password") {
        emit(UserAuthenticatedError("wrong password"));
      } else {
        emit(UserAuthenticatedError(e.code.toString()));
      }
    }
  }

  Future<void> reAssignUsersLogin(BuildContext context) async {
    try {
      UserAuthenticating();
      final user = await userRespositories.currentUser();
      userDetails = user;
      changeScreen(context, WelcomeAuth());

      emit(NormalUserAuthenticated(user));
    } on FirebaseException catch (e) {
      if (e.code == "user-not-found") {
        emit(UserAuthenticatedError("Wrong email"));
      } else if (e.code == "wrong-password") {
        emit(UserAuthenticatedError("wrong password"));
      } else {
        emit(UserAuthenticatedError(e.code.toString()));
      }
    }
  }

  Future<void> userDetailsAssignment(BuildContext context) async {
    try {
      UserAuthenticating();
      final user = await userRespositories.currentUser();
      userDetails = user;
      emit(NormalUserAuthenticated(user));
    } on FirebaseException catch (e) {
      if (e.code == "user-not-found") {
        emit(UserAuthenticatedError("Wrong email"));
      } else if (e.code == "wrong-password") {
        emit(UserAuthenticatedError("wrong password"));
      } else {
        emit(UserAuthenticatedError(e.code.toString()));
      }
    }
  }

  Future<void> userRestaurantLogout(BuildContext context) {
    try {
      userRespositories.logoutUserAccount();
      changeScreen(context, WelcomeUnAuth());

      emit(UsersInitial());
    } on FirebaseAuthException catch (e) {
      emit(UserAuthenticatedError(e.code));
    }
  }
}
