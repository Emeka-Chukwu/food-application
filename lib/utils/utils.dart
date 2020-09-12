import 'package:flutter/material.dart';

double screenHeight(BuildContext context, {double percent: 1}) {
  return MediaQuery.of(context).size.height * percent;
}

double screenWidth(BuildContext context, {double percent: 1}) {
  return MediaQuery.of(context).size.width * percent;
}

class Xmargin extends StatelessWidget {
  final double width;
  Xmargin(this.width);
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}

class Ymargin extends StatelessWidget {
  final double height;
  Ymargin(this.height);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

void changeScreen(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}
