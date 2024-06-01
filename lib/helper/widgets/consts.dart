import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

const bgColor = Color.fromARGB(255, 136, 255, 239);
const blueColor = Color.fromRGBO(0, 149, 246, 1);

const primaryColor = Colors.white;
const secondaryColor = Colors.grey;
const tertiaryColor = Color.fromRGBO(97, 97, 97, 1);

var messageFontSize = 16.0;

Color senderColor = Colors.green;
Color receiverColor = Colors.blue;

Color backgroundScreenColor = const Color.fromARGB(255, 195, 250, 245);
Color appBarColor = const Color.fromARGB(255, 135, 255, 240);
Color appBarShadowColor = const Color.fromARGB(255, 35, 255, 215);

Color txtColor = Colors.black;
Color titleColor = Colors.black;

Color formContainerFillColor = const Color.fromARGB(255, 190, 255, 225);
Color formButtonFillColor = Colors.purpleAccent;

var gradientBackground = const LinearGradient(
  colors: [Color.fromARGB(255, 194, 251, 246), Colors.white],
  begin: FractionalOffset(0.0, 0.0),
  end: FractionalOffset(0.0, 1.0),
  stops: [1.0, 1.0],
  tileMode: TileMode.clamp,
);

Widget sizeVer(double height) {
  return SizedBox(
    height: height,
  );
}

Widget sizeHor(double width) {
  return SizedBox(
    width: width,
  );
}
