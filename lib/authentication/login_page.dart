// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/authentication/reset_password.dart';
import 'package:chat_app/authentication/signup_page.dart';
import 'package:chat_app/helper/ui_helper.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/helper/widgets/form_button.dart';
import 'package:chat_app/helper/widgets/form_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/helper/widgets/consts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emails = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ChatBox',
          style: GoogleFonts.playfairDisplay(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
        backgroundColor: appBarColor,
        centerTitle: true,
        shadowColor: appBarShadowColor,
        elevation: 5,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          color: backgroundScreenColor,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: txtColor,
                    ),
                  ),
                  FormContainerWidget(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    inputType: TextInputType.emailAddress,
                    icon: Icons.email,
                    controller: emails,
                  ),
                  FormContainerWidget(
                    labelText: 'Password',
                    hintText: 'Enter your Password',
                    inputType: TextInputType.visiblePassword,
                    icon: Icons.password,
                    controller: password,
                    isPasswordField: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Forgot your Password?'),
                      CupertinoButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ResetPasswordPage(),
                            ),
                          ).then((result) {});
                        },
                        child: const Text(
                          'Reset Password',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: blueColor,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  FormButtonWidget(
                    text: 'Log In',
                    backgroundColor: Colors.purpleAccent,
                    textColor: txtColor,
                    onPressed: () {
                      checkValues();
                    },
                  ),
                  Text(
                    "Or",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FormButtonWidget(
                    text: "Log In using Google",
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    imagePath: "assets/googleicon.png",
                    onPressed: () async {
                      await logInWithGoogle();
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Don\'t have an account?'),
                      CupertinoButton(
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignupPage()))
                              .then((result) {});
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: blueColor,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void checkValues() {
    String email = emails.text.trim();
    String pass = password.text.trim();

    if (email == "" || pass == "") {
      UIHelper.toast("Please fill all the fields!", Toast.LENGTH_LONG,
          ToastGravity.BOTTOM);
    } else {
      logIn(email, pass);
    }
  }

  void logIn(String email, String pass) async {
    UserCredential? credential;
    UIHelper.showLoadingDialog(context, "Logging In...");

    try {
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (ex) {
      String str = ex.code.toString();
      Navigator.pop(context);
      UIHelper.toast(str, Toast.LENGTH_LONG, ToastGravity.BOTTOM);
    }

    if (credential != null) {
      String uid = credential.user!.uid;

      DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();

      UserModel usermodel =
          UserModel.fromMap(userData.data() as Map<String, dynamic>);

      UIHelper.toast(
          "Welcome Back - ${usermodel.name}", Toast.LENGTH_LONG, ToastGravity.BOTTOM);
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            userModel: usermodel,
            firebaseUser: credential!.user!,
          ),
        ),
      );
    }
  }

  Future<void> logInWithGoogle() async {
    UIHelper.showLoadingDialog(context, "Logging In with Google...");
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        User? user = userCredential.user;
        if (user != null) {
          DocumentSnapshot userData = await FirebaseFirestore.instance
              .collection("users")
              .doc(user.uid)
              .get();
          if (userData.exists) {
            UserModel usermodel =
                UserModel.fromMap(userData.data() as Map<String, dynamic>);
            UIHelper.toast(
                "Welcome Back - ${usermodel.name}", Toast.LENGTH_LONG, ToastGravity.BOTTOM);
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  userModel: usermodel,
                  firebaseUser: user,
                ),
              ),
            );
          } else {
            UIHelper.toast(
                "User not found", Toast.LENGTH_LONG, ToastGravity.BOTTOM);
          }
        } else {
          UIHelper.toast(
              "User not found", Toast.LENGTH_LONG, ToastGravity.BOTTOM);
        }
      } else {
        UIHelper.toast(
            "User not found", Toast.LENGTH_LONG, ToastGravity.BOTTOM);
      }
    } catch (e) {
      Navigator.pop(context);
      UIHelper.toast("Error: $e", Toast.LENGTH_LONG, ToastGravity.BOTTOM);
    }
  }
}
