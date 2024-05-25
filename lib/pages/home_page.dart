import 'package:chat_app/authentication/login_page.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/pages/search_page.dart';
import 'package:chat_app/widgets/consts.dart';
import 'package:chat_app/widgets/form_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const HomePage(
      {super.key, required this.userModel, required this.firebaseUser});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
      drawer: Drawer(
        elevation: 5,
        shadowColor: const Color.fromARGB(255, 36, 255, 215),
        backgroundColor: bgColor,
        surfaceTintColor: primaryColor,
        child: ListView(
          children: [
            sizeVer(20),
            CircleAvatar(
              backgroundImage: NetworkImage(widget.userModel.profilepic!),
              backgroundColor: blueColor,
              radius: 60,
            ),
            sizeVer(20),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(
                "Hello, ",
                style: GoogleFonts.dancingScript(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
                softWrap: true,
              ),
            ),
            Text(
              widget.userModel.name!,
              style: GoogleFonts.dancingScript(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: Colors.red,
                backgroundColor: const Color.fromARGB(255, 120, 230, 255),
                letterSpacing: 1.5,
              ),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
            // Text(
            //   "Email: ${widget.userModel.email!}",
            //   style: const TextStyle(
            //     fontSize: 20,
            //     fontWeight: FontWeight.bold,
            //     backgroundColor: Color.fromARGB(255, 120, 230, 255),
            //   ),
            //   textAlign: TextAlign.center,
            //   softWrap: true,
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Future.delayed(const Duration(milliseconds: 120), () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchPage(
                  userModel: widget.userModel,
                  firebaseUser: widget.firebaseUser,
                ),
              ),
            );
          });
        },
        elevation: 5,
        backgroundColor: const Color.fromARGB(255, 251, 194, 255),
        splashColor: Colors.blue,
        child: const Icon(
          Icons.search_sharp,
          size: 30,
          shadows: [Shadow(color: Colors.black)],
        ),
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
                    'Welcome to ChatBox',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'You are now logged in',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FormButtonWidget(
                    text: 'Logout',
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
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
