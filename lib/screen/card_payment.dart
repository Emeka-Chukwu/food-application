import 'package:flutter/material.dart';

class CardPaymentSection extends StatefulWidget {
  @override
  _CardPaymentSectionState createState() => _CardPaymentSectionState();
}

class _CardPaymentSectionState extends State<CardPaymentSection> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Card Payment Details",
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
                    Container(height: 180, color: Colors.blueGrey[100]),
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
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'NAME',
                                )))),
                    Padding(padding: const EdgeInsets.all(4)),
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
                                  hintText: 'CARD NUMBER',
                                )))),
                    Padding(padding: const EdgeInsets.all(4)),
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
                                  hintText: 'Year',
                                )))),
                    Padding(padding: const EdgeInsets.all(4)),
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
                                  hintText: 'CCV',
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
                            child: Text("PAY ORDER",
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
