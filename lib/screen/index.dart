import 'package:flutter/material.dart';
import 'package:foodApp/widget/category.dart';
import 'package:foodApp/widget/restaurant_widget.dart';

class HomeAllCategory extends StatefulWidget {
  @override
  _HomeAllCategoryState createState() => _HomeAllCategoryState();
}

class _HomeAllCategoryState extends State<HomeAllCategory> {
  List<String> images = List<String>();
  @override
  void initState() {
    super.initState();

    // ignore: todo
    // TODO: implement initState

    images = ["categories", "category1", "category2", "category3", "category4"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: ListView.builder(
              itemCount: images.length ?? 0,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, indexPosition) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                      padding: const EdgeInsets.all(4),
                      // return CategoryWidget(images: images, indexPos: indexPosition);
                      child: CategoryWidget(
                          images: images, indexPos: indexPosition)),
                );
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: ListView.builder(
              itemCount: images.length ?? 0,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, indexPosition) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                      padding: const EdgeInsets.all(4),
                      // return CategoryWidget(images: images, indexPos: indexPosition);
                      child: RestaurantWidget(
                          images: images, indexPos: indexPosition)),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
