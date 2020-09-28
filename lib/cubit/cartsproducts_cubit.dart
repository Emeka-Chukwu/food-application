// import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodApp/model/cart_model.dart';
import 'package:foodApp/repositories/cartsproducts.dart';
// import 'package:foodApp/screen/cart_order_page.dart';
// import 'package:foodApp/utils/utils.dart';
import 'package:meta/meta.dart';

part 'cartsproducts_state.dart';

class CartsproductsCubit extends Cubit<CartsproductsState> {
  final CartRepository cartRepository;
  CartsproductsCubit(this.cartRepository) : super(CartsproductsInitial());

  Future<void> getUserProductsCart(BuildContext context) async {
    try {
      emit(CartsproductLoading());
      final productsList =
          await cartRepository.getAllUserProductsFromDatabase();
      emit(CartsproductLoaded(carts: productsList));
      print(productsList);
      print("objectvvvvvvvvvvvvvvvvvvvv");

      // changeScreen(context, CartOrderPage());

      // changeScreen(context, ProductsScreen());
    } on FirebaseException catch (e) {
      emit(CartsProductsError(message: e.toString()));
    }
  }

  void getNewCartsAfterItemRemoval(int num, List<dynamic> carts) {
    carts.removeAt(num);
    emit(CartsproductLoaded(carts: carts));
  }
}
