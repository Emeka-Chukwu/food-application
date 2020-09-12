import 'package:flutter/material.dart';
import 'package:foodApp/utils/utils.dart';

class PlaceReviewSection extends StatelessWidget {
  final int index;
  PlaceReviewSection({this.index});
  final List<int> checking = [1, 2, 3, 4, 5];
  final reviews = [
    {
      "name": "emeka",
      "rating": 4,
      "review":
          "this restaurant is the best place i have ever had a meal in here in  Abeokuta",
      "avatar": "avatar1.jpg"
    },
    {
      "name": "steven",
      "rating": 5,
      "avatar": "avatar2.png",
      "review":
          "this restaurant is the best place i have ever had a meal in here in  Abeokuta"
    },
    {
      "name": "prince",
      "rating": 2,
      "avatar": "avatar1.jpg",
      "review":
          "this restaurant is the best place i have ever had a meal in here in  Abeokuta"
    },
    {
      "name": "olamide",
      "rating": 3,
      "avatar": "avatar2.png",
      "review":
          "this restaurant is the best place i have ever had a meal in here in  Abeokuta"
    },
    {
      "name": "emeka",
      "rating": 4,
      "avatar": "avatar1.jpg",
      "review":
          "this restaurant is the best place i have ever had a meal in here in  Abeokuta"
    },
    {
      "name": "kent",
      "rating": 1,
      "avatar": "avatar1.jpg",
      "review":
          "this restaurant is the best place i have ever had a meal in here in  Abeokuta"
    },
    {
      "name": "Gbenga",
      "rating": 5,
      "avatar": "avatar2.png",
      "review":
          "this restaurant is the best place i have ever had a meal in here in  Abeokuta"
    }
  ];
  Icon icons(int rating, int rated) => Icon(
        Icons.star,
        color: rating <= rated ? Colors.amber : Colors.black12,
      );
  Icon icons2(int rate) => Icon(
        Icons.star,
        color: rate < 5 ? Colors.amber : Colors.black12,
      );

  final DateTime today = new DateTime.now();

  //     final DateTime now = DateTime.now();
  // final DateFormat formatter = DateFormat('yyyy-MM-dd');
  // final String formatted = formatter.format(now);
  // int _totalAvg = 0;
  // String _totalString = '';
  // int _totalReviewsAvg (){
  //     for(int i = 0; i < reviews.length; i++){
  //       _totalAvg += reviews[i]["rating"];
  //     }
  //     _totalString = (_totalAvg/reviews.length).toString();
  //     _totalAvg = int.parse(_totalString);
  // }

  @override
  Widget build(BuildContext context) {
    String dateSlug =
        "${today.year.toString()}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

    return Container(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        index == 0
            ? Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${reviews.length} Reviews"),
                      Row(children: checking.map((e) => icons(e, 3)).toList()),
                      // Row(
                      //     children: checking
                      //         .map((e) => IconButton(
                      //             icon: Icon(Icons.access_alarm),
                      //             onPressed: () => print("$e")))
                      //         .toList()),
                    ],
                  ),
                ),
              )
            : Row(),
        // Divider(),
        Ymargin(9),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              height: 105,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "images/${reviews[index]["avatar"]}",
                          height: 64,
                          width: 64,
                          fit: BoxFit.contain,
                        ),
                        Expanded(
                            child: Column(
                          children: [
                            Text(
                              "${reviews[index]["name"]}",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text("$dateSlug")
                          ],
                        )),
                        Row(
                            children: checking
                                .map((e) => icons(e, reviews[index]["rating"]))
                                .toList()),
                      ],
                    ),
                    Ymargin(7),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("${reviews[index]["review"]}"))
                  ])),
        )
      ]),
    );
  }
}
