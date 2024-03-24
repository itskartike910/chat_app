import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_fonts/google_fonts.dart';

const backGroundColor=Color.fromRGBO(0, 0, 0, 1.0);
const blueColor=Color.fromRGBO(0, 149, 246, 1);
const primaryColor=Colors.white;
const secondaryColor=Colors.grey;
const darkGreyColor=Color.fromRGBO(97, 97, 97, 1);
var messageFontSize=16.0;
Color senderColor=Colors.pink;
Color receiverColor=Colors.blue;

var lightPinkBackground=LinearGradient(
    colors: [Colors.pink.shade50,Colors.white],
      begin: const FractionalOffset(0.0, 0.0),
      end: const FractionalOffset(0.0, 1.0),
      stops: const [1.0,1.0],
      tileMode: TileMode.clamp,
);

Widget sizeVer(double height)
{
  return SizedBox(height: height,);
}
Widget sizeHor(double width)
{
  return SizedBox(width: width,);
}

void toast(String message){
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: blueColor,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

