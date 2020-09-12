import 'package:flutter/material.dart';
import 'package:foodApp/utils/utils.dart';

class CartOrderPage extends StatefulWidget {
  @override
  _CartOrderPageState createState() => _CartOrderPageState();
}

class _CartOrderPageState extends State<CartOrderPage> {
  final orders = [
    {"name": "hamburger", "price": 12, "quantity": 1, "image": "hamburger.jpg"},
    {
      "name": "macdonald rice",
      "price": 14,
      "quantity": 1,
      "image": "macdonaldrice.jpg"
    },
    {
      "name": "spicy tofu",
      "price": 13,
      "quantity": 1,
      "image": "spicytofu.jpg"
    },
    {"name": "burger", "price": 15, "quantity": 1, "image": "burger.jpg"}
  ];

  final quantity = [1, 1, 1, 1];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Order"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              height: screenHeight(context, percent: .6),
              child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                            child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              "images/${orders[index]["image"]}",
                              height: 84,
                              width: 84,
                            ),
                            Column(children: [
                              Text("${orders[index]["name"]}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Ymargin(8),
                              Text("\$${orders[index]["price"]}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green))
                            ]),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.black45,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        quantity[index]++;
                                      });
                                    },
                                  ),
                                  Text("${quantity[index]}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  IconButton(
                                    icon: Icon(
                                      Icons.remove,
                                      color: Colors.black45,
                                    ),
                                    onPressed: () {
                                      if (quantity[index] > 1) {
                                        setState(() {
                                          quantity[index]--;
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                        Divider(),
                      ],
                    );
                  })),
          Text("TOTAL \$25",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green)),
          Container(
              height: 40,
              width: screenWidth(context, percent: .6),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(10)),
              child: Align(
                alignment: Alignment.center,
                child: Text("ADD TO CART",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ))
        ],
      ),
    );
  }
}
