import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodApp/cubit/products_cubit.dart';
import 'package:foodApp/cubit/restaurant_cubit.dart';
import 'package:foodApp/utils/utils.dart';

class WelcomeAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final restaurantCubit = context.bloc<RestaurantCubit>();
    final productsCubits = context.bloc<ProductsCubit>();
    return Scaffold(
        backgroundColor: Colors.green,
        body: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Ymargin(15),
                Text("Foodio",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic)),
                Container(
                  width: screenWidth(context, percent: 0.85),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            offset: Offset(0, 5),
                            blurRadius: 25)
                      ]),
                  child: Column(children: [
                    Ymargin(10),
                    Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            productsCubits.getAllProducts(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text("Popular Foods",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic))),
                          ),
                        )),

                    // llllllllllllllllll

                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                          onTap: () {
                            restaurantCubit.getRestuarantsList(context);
                          },
                          child: Container(
                            height: 70,
                            width: screenWidth(context),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Foods by Restaurants",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic))),
                            ),
                          )),
                    ),
                    Ymargin(10),
                  ]),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.location_on,
                              color: Colors.white, size: 35),
                          Ymargin(10),
                          Text("Abeokuta, Nigeria",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic))
                        ])),
                Ymargin(10)
              ]),
        ));
  }
}
