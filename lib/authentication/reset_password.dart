// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/helper/ui_helper.dart';
import 'package:chat_app/helper/widgets/consts.dart';
import 'package:chat_app/helper/widgets/form_button.dart';
import 'package:chat_app/helper/widgets/form_container.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _resetPassword() async {
    String email = emailController.text.trim();
    if (email.isEmpty) {
      UIHelper.toast("Please enter your email address.", Toast.LENGTH_LONG,
          ToastGravity.BOTTOM);
      return;
    }

    UIHelper.showLoadingDialog(context, "Sending Password Reset Email...");
    try {
      await _auth.sendPasswordResetEmail(email: email);
      UIHelper.toast(
          "Password reset email sent!", Toast.LENGTH_LONG, ToastGravity.BOTTOM);
    } catch (e) {
      UIHelper.toast(
          "Error: ${e.toString()}", Toast.LENGTH_LONG, ToastGravity.BOTTOM);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ChatBox',
          style: GoogleFonts.playfairDisplay(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: bgColor,
        centerTitle: true,
        shadowColor: const Color.fromARGB(255, 36, 255, 215),
        elevation: 5,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: gradientBackground,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Reset Password',
                style: GoogleFonts.playfairDisplay(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
              ),
              sizeVer(30),
              FormContainerWidget(
                labelText: 'Email',
                hintText: 'Enter your email',
                inputType: TextInputType.emailAddress,
                icon: Icons.email,
                controller: emailController,
              ),
              sizeVer(10),
              FormButtonWidget(
                text: 'Send Reset Email',
                backgroundColor: Colors.purpleAccent,
                textColor: Colors.black,
                onPressed: () {
                  _resetPassword();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
