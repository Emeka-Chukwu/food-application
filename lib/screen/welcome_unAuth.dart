import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodApp/cubit/users_cubit.dart';
import 'package:foodApp/screen/login.dart';
import 'package:foodApp/screen/register_restaurant.dart';
import 'package:foodApp/screen/register_user.dart';
import 'package:foodApp/screen/welcome_auth.dart';
import 'package:foodApp/utils/utils.dart';

class WelcomeUnAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usersCubit = context.bloc<UsersCubit>();
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(10),
            child: BlocBuilder<UsersCubit, UsersState>(
              builder: (context, state) {
                if (state is NormalUserAuthenticated) {
                  return WelcomeAuth();
                } else if (state is RestaurantUserAuthenticated) {
                  return WelcomeAuth();
                } else if (state is UsersInitial) {
                  if (usersCubit.userRespositories.currentUserExist()) {
                    // usersCubit.reAssignUsersLogin(context);
                    // return Container();
                  }
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * .4,
                              child: Image.asset("images/welcomeUnauth.jpg",
                                  // fit: BoxFit.cover
                                  fit: BoxFit.cover)),
                        ),
                        Expanded(
                          flex: 3,
                          child: Card(
                            child: Container(
                              width: double.infinity,
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Ymargin(10),
                                    Text(
                                      "Foodio",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "italics"),
                                    ),
                                    Ymargin(8),
                                    GestureDetector(
                                        onTap: () {
                                          changeScreen(context, RegisterUser());
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .70,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text("SIGN UP",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        )),
                                    Ymargin(4),
                                    GestureDetector(
                                        onTap: () {
                                          changeScreen(context, LoginPage());
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .70,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text("LOGIN",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        )),
                                    Ymargin(4),
                                    GestureDetector(
                                        onTap: () {
                                          changeScreen(
                                              context, RegisterRestaurant());
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .70,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text("SIGN UP (Restuarant)",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        )),
                                    Ymargin(4),
                                  ]),
                            ),
                          ),
                        ),
                      ]);
                }
              },
            )));
  }
}
