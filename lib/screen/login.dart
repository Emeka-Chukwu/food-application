import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodApp/cubit/users_cubit.dart';
import 'package:foodApp/screen/restaurants.dart';
import 'package:foodApp/screen/welcome_auth.dart';

// import 'package:foodApp/screen/welcome_auth.dart';
// import 'package:foodApp/utils/utils.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final usersCubit = context.bloc<UsersCubit>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("SIGN IN",
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
        key: usersCubit.userRespositories.loginFormKey,
        child: Container(child:
            BlocBuilder<UsersCubit, UsersState>(builder: (context, state) {
          if (state is NormalUserAuthenticated) {
            return WelcomeAuth();
          } else if (state is RestaurantUserAuthenticated) {
            return RestaurantsScreen();
          } else {
            return Padding(
              padding: const EdgeInsets.all(6.0),
              child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * .80,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[100],
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 50),
                            child: TextFormField(
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (String email) => usersCubit
                                    .userRespositories
                                    .getEmail(email),
                                validator: (String value) => usersCubit
                                    .userRespositories
                                    .validateString(value),
                                onChanged: (String email) => usersCubit
                                    .userRespositories
                                    .getEmail(email),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'EMAIL ADDRESS',
                                )))),
                    Padding(padding: const EdgeInsets.all(15)),
                    Container(
                        width: MediaQuery.of(context).size.width * .90,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[100],
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 50),
                            child: TextFormField(
                                textAlign: TextAlign.center,
                                onSaved: (String password) => usersCubit
                                    .userRespositories
                                    .getPassword(password),
                                onChanged: (String password) => usersCubit
                                    .userRespositories
                                    .getPassword(password),
                                validator: (String value) => usersCubit
                                    .userRespositories
                                    .validateString(value),
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'YOUR PASSWORD',
                                )))),
                    Padding(padding: const EdgeInsets.all(15)),
                    GestureDetector(
                        onTap: () {
                          usersCubit.loginUser(context);
                          // changeScreen(context, WelcomeAuth());
                          // changeScreen(context, WelcomeAuth());
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          width: MediaQuery.of(context).size.width * .90,
                          // height: ,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("LOG IN",
                                style: TextStyle(color: Colors.white)),
                          ),
                        )),
                    Padding(padding: const EdgeInsets.all(12)),
                    Center(child: Text("OR")),
                    Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child: GestureDetector(
                                onTap: () =>
                                    usersCubit.loginRestaurantUser(context),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 1),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.blue[900],
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text("LOGIN (Restaurant)",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                )),
                          ),
                          Center(
                            child: Image.asset("images/foodio_login.jpg",
                                fit: BoxFit.contain),
                          )
                        ]))
                  ]),
            );
          }
        })),
      ),
    );
  }
}
