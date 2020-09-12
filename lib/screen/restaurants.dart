import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodApp/cubit/restaurant_cubit.dart';
import 'package:foodApp/cubit/users_cubit.dart';
import 'package:foodApp/screen/product_create.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:foodApp/cubit/restaurant_cubit.dart';
import 'package:foodApp/utils/utils.dart';
// import 'package:foodApp/utils/utils.dart';

class RestaurantsScreen extends StatefulWidget {
  @override
  _RestaurantsScreenState createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
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
    // final restaurantDetailsCubit = context.bloc<RestaurantCubit>();
    final usersCubit = context.bloc<UsersCubit>();
    final userCubit = context.bloc<UsersCubit>();
    print("restauuuuuuuuuuuuuurant");
    print(usersCubit.state);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Restaurants Nearby"),
          actions: [
            usersCubit.state is NormalUserAuthenticated
                ? Stack(children: [
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 3),
                        child: Container(
                          height: 20,
                          width: 25,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.red),
                          child: Center(child: Text("20")),
                        ),
                      ),
                    )
                  ])
                : Container(),
            usersCubit.state is RestaurantUserAuthenticated
                ? IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () => changeScreen(context, CreateProduct()))
                : Container(),
          ],
        ),
        body: BlocBuilder<RestaurantCubit, RestaurantState>(
          builder: (context, state) {
            if (state is RestaurantInitial || state is RestaurantLoading) {
              return ProgressIndicator();
            } else if (state is RestaurantLoaded) {
              if (state.restaurants.length <= 0) {
                print(state.restaurants.length);
                return EmptyRestaurantList();
              }
              return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => setState(() {
                              _title = 0;
                            }),
                            child: Text("Restuarant List",
                                style: TextStyle(
                                    color: _title == 0
                                        ? Colors.green
                                        : Colors.black)),
                          ),
                          GestureDetector(
                            onTap: () => setState(() {
                              _title = 1;
                            }),
                            child: Text("Restuarant Map",
                                style: TextStyle(
                                    color: _title == 1
                                        ? Colors.green
                                        : Colors.black)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        height: screenHeight(context, percent: 0.80),
                        child: GridView.builder(
                            itemCount: state.restaurants.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 2,
                                    mainAxisSpacing: 45),
                            itemBuilder: (context, index) {
                              final imageRes =
                                  state.restaurants[index].imageUrl != null
                                      ? "${state.restaurants[index].imageUrl}"
                                      : "images/category1.jpg";

                              return Container(
                                height: 400,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5)),
                                      child:
                                          state.restaurants[index].imageUrl !=
                                                  null
                                              ? Image.network(
                                                  "$imageRes",
                                                  height: 100,
                                                  width: 170,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  "$imageRes",
                                                  height: 100,
                                                  width: 170,
                                                  fit: BoxFit.cover,
                                                ),
                                    ),
                                    Ymargin(5),
                                    Text("${state.restaurants[index].name}"),
                                    Ymargin(5),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Text(
                                            "${state.restaurants[index].description}"),
                                      ),
                                    ),
                                    Ymargin(5),
                                    Container(
                                      height: 30,
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
                              );
                            }),
                      ),
                    )
                  ]);
            } else {
              return Container();
            }
          },
        ),
        // drawer: ,
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
        )));
  }
}

class ProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Text(
          "restaurant data loading",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        CircularProgressIndicator(backgroundColor: Colors.green)
      ]),
    );
  }
}

class EmptyRestaurantList extends StatelessWidget {
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
