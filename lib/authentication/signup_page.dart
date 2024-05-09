import 'package:chat_app/authentication/complete_profile_page.dart';
import 'package:chat_app/authentication/login_page.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/widgets/form_button.dart';
import 'package:chat_app/widgets/form_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/widgets/consts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  //Text Editing Controllers
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final cnfpassword = TextEditingController();

  String? pass;
  String? cnfpass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ChatBox',
          style: TextStyle(
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
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FormContainerWidget(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    inputType: TextInputType.emailAddress,
                    icon: Icons.email,
                    controller: email,
                  ),
                  FormContainerWidget(
                    labelText: 'Password',
                    hintText: 'Create your password',
                    inputType: TextInputType.visiblePassword,
                    icon: Icons.password,
                    isPasswordField: true,
                    controller: password,
                  ),
                  FormContainerWidget(
                    labelText: 'Confirm Password',
                    hintText: 'Enter your password again',
                    inputType: TextInputType.visiblePassword,
                    icon: Icons.password,
                    isPasswordField: true,
                    controller: cnfpassword,
                  ),
                  // Text(
                  //   password == cnfpassword
                  //       ? "Passwords match"
                  //       : "Passwords do not match",
                  //   style: TextStyle(
                  //       color: password == cnfpassword
                  //           ? Colors.green
                  //           : Colors.red),
                  // ),
                  sizeVer(20),
                  FormButtonWidget(
                    text: 'Sign Up',
                    backgroundColor: Colors.purpleAccent,
                    textColor: Colors.black,
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CompleteProfilePage()))
                          .then((result) {});
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Already have an account?'),
                      CupertinoButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Log In',
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
}
