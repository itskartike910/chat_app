import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/authentication/signup_page.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const FormContainerWidget(
              labelText: 'Email',
              hintText: 'Enter your email',
              inputType: TextInputType.emailAddress,
            ),
            const FormContainerWidget(
              labelText: 'Password',
              hintText: 'Enter your Password',
              inputType: TextInputType.visiblePassword,
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
    );
  }
}
