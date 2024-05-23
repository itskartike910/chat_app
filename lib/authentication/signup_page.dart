import 'package:chat_app/authentication/complete_profile_page.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/widgets/form_button.dart';
import 'package:chat_app/widgets/form_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/widgets/consts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  //Text Editing Controllers
  TextEditingController emails = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cnfpassword = TextEditingController();

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
                    controller: emails,
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
                  sizeVer(20),
                  FormButtonWidget(
                    text: 'Sign Up',
                    backgroundColor: Colors.purpleAccent,
                    textColor: Colors.black,
                    onPressed: () {
                      checkValues();
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

  void checkValues() {
    String email = emails.text.trim();
    String pass = password.text.trim();
    String cnfpass = cnfpassword.text.trim();

    if (email == "" || pass == "" || cnfpass == "") {
      toast("Please fill all the fields!", Toast.LENGTH_LONG);
    } else if (pass != cnfpass) {
      toast("Passwords do not match!", Toast.LENGTH_LONG);
    } else {
      signUp(email, pass);
    }
  }

  void signUp(String email, String pass) async {
    UserCredential? credential;

    try {
      credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (ex) {
      String str = ex.code.toString();
      toast(str, Toast.LENGTH_LONG);
    }

    if (credential != null) {
      String uid = credential.user!.uid;

      UserModel newUser = UserModel(
        uid: uid,
        email: email,
        name: '',
        profilepic: '',
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(newUser.toMap())
          .then(
            (value) => {
              toast("SignUp Successful..New User Created!", Toast.LENGTH_SHORT),
              Navigator.pop(context),
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CompleteProfilePage(
                    userModel: newUser,
                    firebaseUser: credential!.user!,
                  ),
                ),
              )
            },
          );
    }
  }
}
