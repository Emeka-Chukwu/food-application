import 'package:flutter/material.dart';
import 'package:foodApp/utils/utils.dart';

// ignore: must_be_immutable
class FoodMenuSection extends StatefulWidget {
  final List<String> foodMenu;
  final List<int> prices;
  int index;
  FoodMenuSection({this.foodMenu, this.index, this.prices});

  @override
  _FoodMenuSectionState createState() => _FoodMenuSectionState();
}

class _FoodMenuSectionState extends State<FoodMenuSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
          height: screenHeight(context, percent: 0.17),
          child: Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "images/${widget.foodMenu[widget.index]}.jpg",
                      height: 100,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                    Xmargin(5),
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${widget.foodMenu[widget.index]}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Ymargin(8),
                              Text(
                                  "this is the description of this wonderful recipe"),
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("\$${widget.prices[widget.index]}",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
                    ),
                  ]),
            ],
          )),
    );
  }
}
