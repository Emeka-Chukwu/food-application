import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodApp/utils/utils.dart';
import 'package:foodApp/widget/food_menu_section.dart';

import 'package:foodApp/widget/place_review_section.dart';

class RestaurantHome extends StatefulWidget {
  @override
  _RestaurantHomeState createState() => _RestaurantHomeState();
}

class _RestaurantHomeState extends State<RestaurantHome> {
  int _title = 0;
  var images = [
    "Abeokuta Burger Store",
    "category1",
  ];

  var foodMenu = [
    "hamburger",
    "burger",
    "macdonaldrice",
    "spicytofu",
    "worcestershire",
    "hamburger",
    "burger",
    "macdonaldrice",
    "spicytofu",
    "worcestershire"
  ];
  final reviews = [
    {
      "name": "emeka",
      "rating": 4,
      "review":
          "this restaurant is the best place i have ever had a meal in here in  Abeokuta",
      "avatar": "avatar1"
    },
    {
      "name": "emeka",
      "rating": 5,
      "avatar": "avatar2",
      "review":
          "this restaurant is the best place i have ever had a meal in here in  Abeokuta"
    },
    {
      "name": "emeka",
      "rating": 2,
      "avatar": "avatar1",
      "review":
          "this restaurant is the best place i have ever had a meal in here in  Abeokuta"
    },
    {
      "name": "emeka",
      "rating": 3,
      "avatar": "avatar2",
      "review":
          "this restaurant is the best place i have ever had a meal in here in  Abeokuta"
    },
    {
      "name": "emeka",
      "rating": 4,
      "avatar": "avatar1",
      "review":
          "this restaurant is the best place i have ever had a meal in here in  Abeokuta"
    },
    {
      "name": "emeka",
      "rating": 1,
      "review":
          "this restaurant is the best place i have ever had a meal in here in  Abeokuta"
    },
    {
      "name": "emeka",
      "rating": 5,
      "review":
          "this restaurant is the best place i have ever had a meal in here in  Abeokuta"
    }
  ];

  var prices = [12, 14, 16, 10, 13, 12, 14, 16, 10, 13];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("${images[0]}"),
        actions: [
          Stack(children: [
            IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: null),
            Positioned(
              right: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 3),
                child: Container(
                  height: 20,
                  width: 25,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                  child: Center(child: Text("20")),
                ),
              ),
            )
          ])
        ],
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              height: screenHeight(context, percent: .29),
              width: screenWidth(context, percent: .96),
              child: ClipRRect(
                child: Image.asset(
                  "images/${images[1]}.jpg",
                  fit: BoxFit.cover,
                  // width: screenWidth(context, percent: .96),
                ),
              )),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          height: 30,
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green, width: 2),
          ),
          child: Align(
              alignment: Alignment.center, child: Text("Ready in 30mins")),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => setState(() {
                  _title = 0;
                }),
                child: Text("FOOD MENU",
                    style: TextStyle(
                        color: _title == 0 ? Colors.green : Colors.black)),
              ),
              GestureDetector(
                onTap: () => setState(() {
                  _title = 1;
                }),
                child: Text("PLACE DETAILS",
                    style: TextStyle(
                        color: _title == 1 ? Colors.green : Colors.black)),
              ),
              GestureDetector(
                onTap: () => setState(() {
                  _title = 2;
                }),
                child: Text("PLACE REVIEWS",
                    style: TextStyle(
                        color: _title == 2 ? Colors.green : Colors.black)),
              ),
            ],
          ),
        ),
        Container(
            height: screenHeight(context, percent: .41),
            child: ListView.builder(
              itemCount: _title == 0
                  ? foodMenu.length
                  : _title == 2 ? reviews.length : 0,
              itemBuilder: (context, index) {
                return _title == 0
                    ? FoodMenuSection(
                        foodMenu: foodMenu,
                        index: index,
                        prices: prices,
                      )
                    : _title == 2
                        ? PlaceReviewSection(
                            index: index,
                          )
                        : Container();
              },
            ))
      ]),
    );
  }
}
