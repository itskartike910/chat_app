import 'package:chat_app/authentication/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/widgets/form_button.dart';
import 'package:chat_app/widgets/form_container.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/widgets/consts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Signup',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const FormContainerWidget(
              labelText: 'Name',
              hintText: 'Enter your name',
              inputType: TextInputType.name,
            ),
            const FormContainerWidget(
              labelText: 'Email',
              hintText: 'Enter your email',
              inputType: TextInputType.emailAddress,
            ),
            const FormContainerWidget(
              labelText: 'Password',
              hintText: 'Enter your password',
              inputType: TextInputType.visiblePassword,
              isPasswordField: true,
            ),
            const SizedBox(height: 20),
            FormButtonWidget(
              text: 'Signup',
              backgroundColor: Colors.purpleAccent,
              textColor: Colors.black,
              onPressed: () {
                // Navigator.pushNamed(context, '/home');
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Already have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()))
                        .then((result) {});
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
