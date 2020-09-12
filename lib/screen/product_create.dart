import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodApp/cubit/products_cubit.dart';
import 'package:foodApp/utils/utils.dart';

class CreateProduct extends StatefulWidget {
  @override
  _CreateProductState createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final productCubit = context.bloc<ProductsCubit>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("CREATE PRODUCT",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: productCubit.productRespositories.productFormkey,
        child: Align(
          alignment: Alignment.center,
          child: Container(
              width: screenWidth(context, percent: .85),
              child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: BlocBuilder<ProductsCubit, ProductsState>(
                    builder: (context, state) {
                      return ListView(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(padding: const EdgeInsets.all(15)),
                            Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: 140,
                                  width: screenWidth(context, percent: .9),
                                  // color: Colors.amber,
                                  child: productCubit.imagePath != null
                                      ? GestureDetector(
                                          onTap: () => productCubit.getImage(),
                                          child: Image.file(
                                              productCubit.imagePath),
                                        )
                                      : IconButton(
                                          icon: Icon(
                                            Icons.cloud_upload,
                                            size: 100,
                                            color: Colors.green,
                                          ),
                                          onPressed: () =>
                                              productCubit.getImage()),
                                )),
                            Padding(padding: const EdgeInsets.all(8)),
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
                                        onChanged: (String name) => productCubit
                                            .productRespositories
                                            .getFullName(name),
                                        onSaved: (String name) => productCubit
                                            .productRespositories
                                            .getFullName(name),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'NAME',
                                        )))),
                            Padding(padding: const EdgeInsets.all(8)),
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
                                        keyboardType: TextInputType.text,
                                        onChanged: (String description) =>
                                            productCubit.productRespositories
                                                .getDescription(description),
                                        onSaved: (String description) =>
                                            productCubit.productRespositories
                                                .getDescription(description),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'DESCRIPTION',
                                        )))),
                            Padding(padding: const EdgeInsets.all(8)),
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
                                        onSaved: (String price) => productCubit
                                            .productRespositories
                                            .getPrice(price),
                                        onChanged: (String price) =>
                                            productCubit.productRespositories
                                                .getPrice(price),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'PRICE',
                                        )))),
                            Padding(padding: const EdgeInsets.all(8)),
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
                                        onSaved: (String categoryName) =>
                                            productCubit.productRespositories
                                                .getCategoryName(categoryName),
                                        onChanged: (String categoryName) =>
                                            productCubit.productRespositories
                                                .getCategoryName(categoryName),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "CATEGORY",
                                        )))),
                            Padding(padding: const EdgeInsets.all(8)),
                            GestureDetector(
                                onTap: () =>
                                    productCubit.uploadDatatoFirestore(context),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 10),
                                  width:
                                      MediaQuery.of(context).size.width * .90,
                                  // height: ,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text("UPLOAD",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                )),
                          ]);
                    },
                  ))),
        ),
      ),
    );
  }
}
