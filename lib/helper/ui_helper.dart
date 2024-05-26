import 'package:chat_app/helper/widgets/consts.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UIHelper {
  static void showLoadingDialog(BuildContext context, String txt) {
    AlertDialog loadingDialog = AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(
            backgroundColor: Colors.redAccent,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            txt,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return loadingDialog;
        });
  }

  static void toast(String message, Toast length, ToastGravity gravity) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: length,
      gravity: gravity,
      timeInSecForIosWeb: 2,
      backgroundColor: blueColor,
      textColor: primaryColor,
      fontSize: 16.0,
    );
  }
}
