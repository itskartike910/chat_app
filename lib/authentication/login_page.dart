import 'package:chat_app/authentication/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/widgets/form_button.dart';
import 'package:chat_app/widgets/form_container.dart';
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
        shadowColor: Colors.white,
        elevation: 0,
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
                  // const Text(
                  //   'ChatBox',
                  //   style: TextStyle(
                  //     fontSize: 45,
                  //     fontWeight: FontWeight.bold,
                  //     color: blueColor
                  //   ),
                  // ),
                  // sizeVer(25),
                  const Text(
                    'LogIn',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FormContainerWidget(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    inputType: TextInputType.emailAddress,
                    controller: email,
                  ),
                  FormContainerWidget(
                    labelText: 'Password',
                    hintText: 'Enter your Password',
                    inputType: TextInputType.visiblePassword,
                    controller: password,
                    isPasswordField: true,
                  ),
                  const SizedBox(height: 20),
                  FormButtonWidget(
                    text: 'Login',
                    backgroundColor: Colors.purpleAccent,
                    textColor: Colors.black,
                    onPressed: () {
                      // Navigator.pushNamed(context, '/register');
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignupPage()))
                              .then((result) {});
                        },
                        child: const Text('Register'),
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
