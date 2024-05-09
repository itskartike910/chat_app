import 'package:chat_app/authentication/signup_page.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/widgets/form_button.dart';
import 'package:chat_app/widgets/form_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/widgets/consts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();
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
                    'Log In',
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
                    hintText: 'Enter your Password',
                    inputType: TextInputType.visiblePassword,
                    icon: Icons.password,
                    controller: password,
                    isPasswordField: true,
                  ),
                  const SizedBox(height: 20),
                  FormButtonWidget(
                    text: 'Log In',
                    backgroundColor: Colors.purpleAccent,
                    textColor: Colors.black,
                    onPressed: () {
                      Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()))
                          .then((result) {});
                    },
                  ),
                  const SizedBox(height: 20),
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
}
