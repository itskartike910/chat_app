import 'package:chat_app/helper/ui_helper.dart';
import 'package:chat_app/helper/widgets/consts.dart';
import 'package:chat_app/helper/widgets/form_button.dart';
import 'package:chat_app/helper/widgets/form_container.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
              const Text(
                "___________________________________________________________________________________________________________________________________",
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: true,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.justify,
              ),
              sizeVer(20),
              Text(
                "Name",
                textAlign: TextAlign.center,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FormContainerWidget(
                enabled: false,
                hintText: widget.user.name,
                inputType: TextInputType.name,
                icon: Icons.person,
              ),
              sizeVer(20),
              Text(
                "Email",
                textAlign: TextAlign.center,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FormContainerWidget(
                enabled: false,
                hintText: widget.user.email,
                inputType: TextInputType.emailAddress,
                icon: Icons.email,
              ),
              // sizeVer(10),
              const Text(
                "___________________________________________________________________________________________________________________________________",
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: true,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.justify,
              ),
              sizeVer(10),
              (widget.currentUser)
                  ? FormButtonWidget(
                      text: 'Edit Profile',
                      backgroundColor: Colors.purpleAccent,
                      textColor: Colors.black,
                      onPressed: () {
                        UIHelper.toast("This feature will be available soon!",
                            Toast.LENGTH_LONG, ToastGravity.BOTTOM);
                      },
                    )
                  : const Text(""),
            ],
          ),
        ),
      ),
    );
  }
}
