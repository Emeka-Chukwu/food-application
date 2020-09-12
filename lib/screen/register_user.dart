import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodApp/cubit/users_cubit.dart';
import 'package:foodApp/screen/restaurants.dart';
import 'package:foodApp/screen/welcome_auth.dart';
import 'package:foodApp/utils/utils.dart';

class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final usersCubit = context.bloc<UsersCubit>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("REGISTER NOW",
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
        key: usersCubit.userRespositories.registerFormkey,
        child: Container(
          child: BlocBuilder<UsersCubit, UsersState>(
            builder: (context, state) {
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
                        Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 140,
                              width: screenWidth(context, percent: .9),
                              // color: Colors.amber,
                              child: usersCubit.imagePath != null
                                  ? GestureDetector(
                                      onTap: () => usersCubit.getImage(),
                                      child: Image.file(usersCubit.imagePath))
                                  : IconButton(
                                      icon: Icon(
                                        Icons.cloud_upload,
                                        size: 100,
                                        color: Colors.green,
                                      ),
                                      onPressed: () => usersCubit.getImage()),
                            )),
                        Padding(padding: const EdgeInsets.all(4)),
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
                                    onSaved: (String name) => usersCubit
                                        .userRespositories
                                        .getFullName(name),
                                    validator: (String val) => usersCubit
                                        .userRespositories
                                        .validateString(val),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'USERNAME',
                                    )))),
                        Padding(padding: const EdgeInsets.all(5)),
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
                                    validator: (String val) => usersCubit
                                        .userRespositories
                                        .validateString(val),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'EMAIL ADDRESS',
                                    )))),
                        Padding(padding: const EdgeInsets.all(5)),
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
                                    obscureText: true,
                                    onSaved: (String password) => usersCubit
                                        .userRespositories
                                        .getPassword(password),
                                    validator: (String val) => usersCubit
                                        .userRespositories
                                        .validateString(val),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Your password',
                                    )))),
                        Padding(padding: const EdgeInsets.all(5)),
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
                                    onSaved: (String confirmPassword) =>
                                        usersCubit.userRespositories
                                            .getConfirmPasword(confirmPassword),
                                    validator: (String val) => usersCubit
                                        .userRespositories
                                        .validateString(val),
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Confirm Password",
                                    )))),
                        Padding(padding: const EdgeInsets.all(5)),
                        GestureDetector(
                            onTap: () => usersCubit.registerUser(),
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
                                child: Text("SIGN UP",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            )),
                        Padding(padding: const EdgeInsets.all(5)),
                        Center(child: Text("OR")),
                        Container(
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 1),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: Colors.blue[900],
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text("CONNECT WITH FACEBOOK",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    )),
                              ),
                              Padding(padding: const EdgeInsets.all(1)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 10),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: Colors.lightBlueAccent,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text("CONNECT WITH TWITTER",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    )),
                              ),
                            ]))
                      ]),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
