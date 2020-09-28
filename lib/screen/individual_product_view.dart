import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodApp/cubit/users_cubit.dart';
import 'package:foodApp/model/cart_model.dart';
import 'package:foodApp/model/product_model.dart';
import 'package:foodApp/utils/utils.dart';

class IndividualProductView extends StatefulWidget {
  final Product product;
  IndividualProductView({this.product});
  @override
  _IndividualProductViewState createState() => _IndividualProductViewState();
}

class _IndividualProductViewState extends State<IndividualProductView> {
  var num = 1;
  @override
  Widget build(BuildContext context) {
    final userCubit = context.bloc<UsersCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        backgroundColor: Colors.green,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Image.network(widget.product.imageUrl,
            fit: BoxFit.contain, height: 150),
        Text("\$${widget.product.price != null ? widget.product.price : 10}",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Text(
            "${widget.product.description != null ? widget.product.description : "American burger snacks"}",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16,
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (num > 1) {
                      setState(() {
                        num--;
                      });
                    }
                  },
                ),
                Text("$num",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      num++;
                    });
                  },
                ),
              ],
            )),
        Container(
            height: 40,
            width: screenWidth(context, percent: .6),
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(10)),
            child: GestureDetector(
              onTap: () {
                // Cart cart = Cart();
                var cartOrder = Cart.fromMap(widget.product.toMap());
                cartOrder.quantity = num;
                userCubit.userRespositories.addToCart(cartOrder);
              },
              child: Align(
                alignment: Alignment.center,
                child: Text("ADD TO CART",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ))
      ]),
    );
  }
}
