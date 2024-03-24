// import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/widgets/form_container.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/consts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const FormContainerWidget(
              labelText: 'Email',
              hintText: 'Enter your email',
              inputType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  // Navigator.pushNamed(context, '/home');
                },
                child: const Text('Login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: blueColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  textStyle: const TextStyle(
                    fontSize: 20,
                  ),
                )),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, '/register');
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
