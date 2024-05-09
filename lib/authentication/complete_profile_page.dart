import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/widgets/consts.dart';
import 'package:chat_app/widgets/form_button.dart';
import 'package:chat_app/widgets/form_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage({super.key});

  @override
  State<CompleteProfilePage> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfilePage> {
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
          child: ListView(
            children: [
              sizeVer(20),
              const Text(
                'Complete Your Profile',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.center,
              ),
              sizeVer(20),
              CupertinoButton(
                onPressed: () {},
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: blueColor,
                  child: Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
              ),
              const Text(
                "Change your profile picture by tapping the icon.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              sizeVer(20),
              FormContainerWidget(
                labelText: 'Name',
                hintText: 'Enter your name',
                inputType: TextInputType.name,
                icon: Icons.person,
              ),
              // FormContainerWidget(
              //   labelText: 'Email',
              //   hintText: 'Enter your email',
              //   inputType: TextInputType.emailAddress,
              //   icon: Icons.email,
              // ),
              // FormContainerWidget(
              //   labelText: 'Phone Number',
              //   hintText: 'Enter your Phone Number',
              //   inputType: TextInputType.number,
              //   icon: Icons.phone,
              // ),
              // FormContainerWidget(
              //   labelText: 'Password',
              //   hintText: 'Create your password',
              //   inputType: TextInputType.visiblePassword,
              //   icon: Icons.password,
              //   isPasswordField: true,
              // ),
              sizeVer(10),
              FormButtonWidget(
                text: 'Save',
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
              sizeVer(10),
              const Text(
                "Or Do it later?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FormButtonWidget(
                text: 'Continue',
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
            ],
          ),
        ),
      ),
    );
  }

  void showPhotoOptions(){
    
  }

}
