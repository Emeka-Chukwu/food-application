import 'package:flutter/material.dart';

class DeliveryDetails extends StatefulWidget {
  @override
  _DeliveryDetailsState createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Delivery Details",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: Form(
        key: formkey,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(padding: const EdgeInsets.all(8)),
                    Container(
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset("images/avatar1.jpg",
                            height: 100, fit: BoxFit.contain),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(9)),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Home Address",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(8)),
                    Container(
                        width: MediaQuery.of(context).size.width * .80,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[100],
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 100),
                            child: TextFormField(
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'YOUR ADDRESS',
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
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'CITY',
                                )))),
                    Padding(padding: const EdgeInsets.all(8)),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[100],
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 50),
                            child: TextFormField(
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'PHONE NUMBER',
                                )))),
                    Padding(padding: const EdgeInsets.all(8)),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[100],
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 50),
                            child: TextFormField(
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '--- --- --',
                                )))),
                    Padding(padding: const EdgeInsets.all(10)),
                    GestureDetector(
                        onTap: () {},
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
                            child: Text("PROCEED TO PAYMENT",
                                style: TextStyle(color: Colors.white)),
                          ),
                        )),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
