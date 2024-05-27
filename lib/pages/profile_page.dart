import 'package:chat_app/helper/widgets/consts.dart';
import 'package:chat_app/helper/widgets/form_button.dart';
import 'package:chat_app/helper/widgets/form_container.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  final UserModel user;
  final bool currentUser;
  const ProfilePage({super.key, required this.user, required this.currentUser});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.playfairDisplay(
            fontSize: 25,
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
              CupertinoButton(
                onPressed: () {},
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: blueColor,
                  backgroundImage:
                      NetworkImage(widget.user.profilepic.toString()),
                  child: (widget.user.profilepic.toString() == "")
                      ? const Icon(
                          Icons.person,
                          size: 80,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
              sizeVer(20),
              FormContainerWidget(
                enabled: false,
                hintText: 'Name: ${widget.user.name}',
                inputType: TextInputType.name,
                icon: Icons.person,
              ),
              FormContainerWidget(
                enabled: false,
                hintText: "Email: ${widget.user.email}",
                inputType: TextInputType.emailAddress,
                icon: Icons.email,
              ),
              sizeVer(10),
              (widget.currentUser)? FormButtonWidget(
                text: 'Edit Profile',
                backgroundColor: Colors.purpleAccent,
                textColor: Colors.black,
                onPressed: () {
                },
              ) : const Text(""),

            ],
          ),
        ),
      ),
    );
  }
}
