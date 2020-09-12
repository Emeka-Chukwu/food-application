import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodApp/cubit/users_cubit.dart';
import 'package:foodApp/screen/restaurants.dart';
import 'package:foodApp/screen/welcome_auth.dart';
import 'package:foodApp/utils/utils.dart';

class RegisterRestaurant extends StatefulWidget {
  @override
  _RegisterRestaurantState createState() => _RegisterRestaurantState();
}

class _RegisterRestaurantState extends State<RegisterRestaurant> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final restaurantCubit = context.bloc<UsersCubit>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("REGISTER RESTAURANT",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
        ),
      ),
      body: Form(
        key: restaurantCubit.userRespositories.restaurantFormkey,
        child: Align(
            alignment: Alignment.center,
            child: BlocBuilder<UsersCubit, UsersState>(
              builder: (context, state) {
                if (state is NormalUserAuthenticated) {
                  return WelcomeAuth();
                } else if (state is RestaurantUserAuthenticated) {
                  return RestaurantsScreen();
                } else {
                  return Container(
                    width: screenWidth(context, percent: .85),
                    child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: ListView(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(padding: const EdgeInsets.all(15)),
                              Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 140,
                                    width: screenWidth(context, percent: .9),
                                    // color: Colors.amber,
                                    child: restaurantCubit
                                                .imagePathRestaurant !=
                                            null
                                        ? GestureDetector(
                                            onTap: () => restaurantCubit
                                                .getRestaurantImage(),
                                            child: Image.file(restaurantCubit
                                                .imagePathRestaurant),
                                          )
                                        : IconButton(
                                            icon: Icon(
                                              Icons.cloud_upload,
                                              size: 100,
                                              color: Colors.green,
                                            ),
                                            onPressed: () => restaurantCubit
                                                .getRestaurantImage()),
                                  )),
                              Padding(padding: const EdgeInsets.all(8)),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * .80,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey[100],
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 50),
                                      child: TextFormField(
                                          textAlign: TextAlign.center,
                                          onSaved: (String name) =>
                                              restaurantCubit.userRespositories
                                                  .getFullName(name),
                                          validator: (String val) =>
                                              restaurantCubit.userRespositories
                                                  .validateString(val),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'NAME',
                                          )))),
                              Padding(padding: const EdgeInsets.all(8)),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * .80,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey[100],
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 50),
                                      child: TextFormField(
                                          textAlign: TextAlign.center,
                                          onSaved: (String email) =>
                                              restaurantCubit.userRespositories
                                                  .getEmail(email),
                                          validator: (String val) =>
                                              restaurantCubit.userRespositories
                                                  .validateString(val),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'EMAIL ADDRESS',
                                          )))),
                              Padding(padding: const EdgeInsets.all(8)),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * .90,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey[100],
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 50),
                                      child: TextFormField(
                                          textAlign: TextAlign.center,
                                          onSaved: (String password) =>
                                              restaurantCubit.userRespositories
                                                  .getPassword(password),
                                          validator: (String val) =>
                                              restaurantCubit.userRespositories
                                                  .validateString(val),
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'YOUR PASSWORD',
                                          )))),
                              Padding(padding: const EdgeInsets.all(8)),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * .80,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey[100],
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 50),
                                      child: TextFormField(
                                          textAlign: TextAlign.center,
                                          onSaved: (String confirmPassword) =>
                                              restaurantCubit.userRespositories
                                                  .getConfirmPasword(
                                                      confirmPassword),
                                          validator: (String val) =>
                                              restaurantCubit.userRespositories
                                                  .validateString(val),
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "CONFIRM PASSWORD",
                                          )))),
                              Padding(padding: const EdgeInsets.all(8)),
                              GestureDetector(
                                  onTap: () =>
                                      restaurantCubit.registerRestaurantUser(),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    width:
                                        MediaQuery.of(context).size.width * .90,
                                    // height: ,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text("SIGN UP",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  )),
                            ])),
                  );
                }
              },
            )),
      ),
    );
  }
}
