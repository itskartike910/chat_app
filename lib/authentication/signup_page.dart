import 'package:chat_app/authentication/login_page.dart';
import 'package:chat_app/widgets/form_button.dart';
import 'package:chat_app/widgets/form_container.dart';
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
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'SignUp',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            FormContainerWidget(
              labelText: 'Name',
              hintText: 'Enter your name',
              inputType: TextInputType.name,
              controller: name,
            ),
            FormContainerWidget(
              labelText: 'Email',
              hintText: 'Enter your email',
              inputType: TextInputType.emailAddress,
              controller: email,
            ),
            FormContainerWidget(
              labelText: 'Password',
              hintText: 'Enter your password',
              inputType: TextInputType.visiblePassword,
              isPasswordField: true,
              controller: password,
            ),
            FormContainerWidget(
              labelText: 'Confirm Password',
              hintText: 'Enter your password again',
              inputType: TextInputType.visiblePassword,
              isPasswordField: true,
              controller: cnfpassword,
            ),
            Text(
              password == cnfpassword
                  ? "Passwords match"
                  : "Passwords do not match",
              style: TextStyle(
                  color: password == cnfpassword ? Colors.green : Colors.red),
            ),
            sizeVer(20),
            FormButtonWidget(
              text: 'SignUp',
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
