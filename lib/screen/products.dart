import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodApp/cubit/cartsproducts_cubit.dart';
import 'package:foodApp/cubit/products_cubit.dart';
import 'package:foodApp/cubit/users_cubit.dart';
import 'package:foodApp/model/cart_model.dart';
// import 'package:foodApp/screen/cart_order_page.dart';
import 'package:foodApp/screen/individual_product_view.dart';
import 'package:foodApp/utils/utils.dart';
// import 'package:foodApp/utils/utils.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  int _title = 0;
  // var images = [
  //   "categories",
  //   "category1",
  //   "category2",
  //   "category3",
  //   "category4",
  //   "categories",
  //   "category1",
  //   "category2",
  //   "category3",
  //   "category4"
  // ];

  @override
  Widget build(BuildContext context) {
    final productDetails = context.bloc<CartsproductsCubit>();
    final userCubit = context.bloc<UsersCubit>();
    final cartsProducts = context.bloc<CartsproductsCubit>().state;
    // userCubit.userDetailsAssignment(context);

    // var cartNumber =
    //     userCubit.state.props != null ? userCubit.state.props[5] : null;
    // print(cartNumber);
    List<Cart> cartNewNumber;
    int numberOfItem = 0;

    // = userCubit.state.props[6];

    if (cartsProducts is CartsproductLoaded) {
      cartNewNumber = cartsProducts.carts;
      for (Cart item in cartNewNumber) {
        numberOfItem += item.quantity;
      }
    }
    print("numberOfitem $numberOfItem");

    print(cartNewNumber);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Products"),
        actions: [
          userCubit.state is NormalUserAuthenticated
              ? GestureDetector(
                  onTap: () {
                    productDetails.getUserProductsCart(context);
                  },
                  child: Stack(children: [
                    IconButton(
                        icon: Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: null),
                    cartNewNumber != null
                        ? Positioned(
                            right: 2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4.0, vertical: 3),
                              child: Container(
                                height: 20,
                                width: 25,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.red),
                                child: Center(child: Text("$numberOfItem")),
                              ),
                            ),
                          )
                        : Container(),
                  ]),
                )
              : Container(),
        ],
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => setState(() {
                  _title = 0;
                }),
                child: Text("Products List",
                    style: TextStyle(
                        color: _title == 0 ? Colors.green : Colors.black)),
              ),
              GestureDetector(
                onTap: () => setState(() {
                  _title = 1;
                }),
                child: Text("Restuarant Map",
                    style: TextStyle(
                        color: _title == 1 ? Colors.green : Colors.black)),
              ),
            ],
          ),
        ),
        BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state is ProductsInitial || state is ProductLoading) {
              return ProgressIndicator();
            } else if (state is ProductLoaded) {
              if (state.products.length == 0) {
                return EmptyProductsList();
              }

              return Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  height: screenHeight(context, percent: .8),
                  child: GridView.builder(
                      itemCount: state.products.length ?? 0,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 35),
                      itemBuilder: (context, index) {
                        return Container(
                          height: 300,
                          child: GestureDetector(
                            onTap: () => changeScreen(
                                context,
                                IndividualProductView(
                                  product: state.products[index],
                                )),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                  child: Image.network(
                                    "${state.products[index].imageUrl}",
                                    height: 78,
                                    width: 170,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Ymargin(4),
                                Text("${state.products[index].name}"),
                                Ymargin(4),
                                Text(
                                    "\$${state.products[index].price != null ? state.products[index].price : 10}"),
                                Ymargin(6),
                                Text(
                                    "${state.products[index].restaurantName != null ? state.products[index].restaurantName : "Abey Eatry"}"),
                                Ymargin(4),
                                Container(
                                  height: 34,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.green, width: 2),
                                  ),
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text("Ready in 30mins")),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              );
            }
            return Container();
          },
        )
      ]),
      drawer: Drawer(child: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          final String nameInitial =
              state is UsersInitial ? "no name" : state.props[0];
          final String email =
              state is UsersInitial ? "no email" : state.props[1];
          return ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.green),
                accountName: Text(
                    "${nameInitial[0].toUpperCase()}${nameInitial.substring(1)}"),
                accountEmail:
                    Text("${email[0].toUpperCase()}${email.substring(1)}"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Text(
                    "${nameInitial[0].toUpperCase()}",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.contacts),
                title: Text("Contact Us"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.contact_mail),
                title: Text("Log out"),
                onTap: () {
                  userCubit.userRestaurantLogout(context);
                },
              ),
            ],
          );
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
