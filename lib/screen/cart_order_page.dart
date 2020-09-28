import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodApp/cubit/cartsproducts_cubit.dart';
import 'package:foodApp/cubit/users_cubit.dart';
import 'package:foodApp/model/cart_model.dart';
import 'package:foodApp/screen/card_payment.dart';
import 'package:foodApp/utils/utils.dart';

class CartOrderPage extends StatefulWidget {
  @override
  _CartOrderPageState createState() => _CartOrderPageState();
}

class _CartOrderPageState extends State<CartOrderPage> {
  // final orders = [
  //   {"name": "hamburger", "price": 12, "quantity": 1, "image": "hamburger.jpg"},
  //   {
  //     "name": "macdonald rice",
  //     "price": 14,
  //     "quantity": 1,
  //     "image": "macdonaldrice.jpg"
  //   },
  //   {
  //     "name": "spicy tofu",
  //     "price": 13,
  //     "quantity": 1,
  //     "image": "spicytofu.jpg"
  //   },
  //   {"name": "burger", "price": 15, "quantity": 1, "image": "burger.jpg"}
  // ];

  // final quantity = [1, 1, 1, 1];
  final Cart cartItem = Cart();
  @override
  Widget build(BuildContext context) {
    // var cartsssss = context.bloc<CartsproductsCubit>();
    // cartsssss.cartRepository.getAllUserProductsFromDatabase();
    var amount = 0;
    void cartsAmount() {
      var cartsCal = context.bloc<CartsproductsCubit>().state;

      if (cartsCal is CartsproductLoaded) {
        var carts = cartsCal.carts;
        for (var i = 0; i < carts.length; i++) {
          print(amount);
          amount += int.parse(carts[i].price) * carts[i].quantity;
        }
        setState(() {
          amount = amount;
        });
      }
    }

    cartsAmount();

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Order"),
        backgroundColor: Colors.green,
      ),
      body:
          Container(child: BlocBuilder<CartsproductsCubit, CartsproductsState>(
        builder: (context, state) {
          final users = context.bloc<UsersCubit>();
          final cartsFunc = context.bloc<CartsproductsCubit>();
          if (state is CartsproductsInitial || state is CartsproductLoading) {
            return ProgressIndicator();
          } else if (state is CartsproductLoaded) {
            final carts = state.carts;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    height: screenHeight(context, percent: .6),
                    child: ListView.builder(
                        itemCount: carts.length ?? 0,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.network(
                                      "${carts[index].imageUrl}",
                                      height: 84,
                                      width: 84,
                                    ),
                                    Column(children: [
                                      Text("${carts[index].name}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      Ymargin(8),
                                      Text("\$${carts[index].price}",
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
                                              // setState(() {
                                              //   carts[index].quantity++;
                                              // });
                                            },
                                          ),
                                          Text("${carts[index].quantity}",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                          IconButton(
                                            icon: Icon(
                                              Icons.remove,
                                              color: Colors.black45,
                                            ),
                                            onPressed: () {
                                              // setState(() {
                                              //   if (carts[index].quantity > 1) {
                                              //     carts[index].quantity--;
                                              //   }
                                              // });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          print("hhhheeeeeeeerrrrrrrrrreeeee");
                                          final cartMap = Cart.fromMap(
                                              carts[index].toMap());
                                          // Cart.fromMap(carts[index])
                                          print(index);
                                          users.userRespositories
                                              .removeFromCart(cartMap);

                                          cartsFunc.getNewCartsAfterItemRemoval(
                                              index, carts);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                              Divider(),
                            ],
                          );
                        })),
                Text("TOTAL \$$amount",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green)),
                GestureDetector(
                  onTap: () => changeScreen(context, CardPaymentSection()),
                  child: Container(
                      height: 40,
                      width: screenWidth(context, percent: .6),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Proceed To Payment",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      )),
                )
              ],
            );
          } else {
            return Container();
          }
        },
      )),
    );
  }
}

class ProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Text(
          "Products data loading",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        CircularProgressIndicator(backgroundColor: Colors.green)
      ]),
    );
  }
}

class EmptyProductsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "No Avalaible Data ",
        style: TextStyle(
            fontSize: 22,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            color: Colors.green),
      ),
    );
  }
}
