import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foodApp/cubit/cartsproducts_cubit.dart';
import 'package:foodApp/cubit/products_cubit.dart';
import 'package:foodApp/cubit/restaurant_cubit.dart';
import 'package:foodApp/cubit/users_cubit.dart';
import 'package:foodApp/repositories/cartsproducts.dart';
import 'package:foodApp/repositories/productsrepository.dart';
import 'package:foodApp/repositories/restaurantrespository.dart';
import 'package:foodApp/repositories/users.dart';
import 'package:foodApp/screen/welcome_unAuth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final RestaurantRespositories restaurantRespositories =
      RestaurantRespositories();
  final ProductRespositories productRespositories = ProductRespositories();
  final UserRespositories userRespositories = UserRespositories();
  final CartRepository cartRepository = CartRepository();

  runApp(MultiBlocProvider(providers: [
    BlocProvider<ProductsCubit>(
      create: (BuildContext context) => ProductsCubit(productRespositories),
    ),
    BlocProvider<RestaurantCubit>(
      create: (BuildContext context) =>
          RestaurantCubit(restaurantRespositories: restaurantRespositories),
    ),
    BlocProvider<UsersCubit>(
      create: (BuildContext context) =>
          UsersCubit(userRespositories: userRespositories),
    ),
    BlocProvider<CartsproductsCubit>(
      create: (BuildContext context) => CartsproductsCubit(cartRepository),
    ),
  ], child: App()));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WelcomeUnAuth(),
    );
  }
}

// return DefaultTabController(
//       length: 4,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("foodio App", style: TextStyle(color: Colors.green)),
//           backgroundColor: Colors.white,
//           elevation: 0,
//           bottom: TabBar(tabs: [
//             Tab(
//               icon: Icon(Icons.looks),
//               child: Text("show A"),
//             ),
//             Tab(
//               icon: Icon(Icons.looks),
//               child: Text("show B"),
//             ),
//             Tab(
//               icon: Icon(Icons.looks),
//               child: Text("show C"),
//             ),
//             Tab(
//               icon: Icon(Icons.looks),
//               child: Text("show D"),
//             )
//           ]),
//         ),
//         drawer: Drawer(),
//         body:
//             TabBarView(children: [Text("A"), Text("B"), Text("C"), Text("D")]),
//       ),
//     );
