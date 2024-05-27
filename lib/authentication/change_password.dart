// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/helper/ui_helper.dart';
import 'package:chat_app/helper/widgets/consts.dart';
import 'package:chat_app/helper/widgets/form_button.dart';
import 'package:chat_app/helper/widgets/form_container.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChangePass extends StatefulWidget {
  final UserModel user;
  const ChangePass({super.key, required this.user});

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ChatBox',
          style: GoogleFonts.playfairDisplay(
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
                  Text(
                    'Change Password',
                    style: GoogleFonts.playfairDisplay(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                  sizeVer(20),
                  FormContainerWidget(
                    labelText: 'Old Password',
                    hintText: 'Enter your Old Password',
                    inputType: TextInputType.visiblePassword,
                    icon: Icons.password,
                    isPasswordField: true,
                    controller: oldPasswordController,
                  ),
                  FormContainerWidget(
                    labelText: 'New Password',
                    hintText: 'Create your new password',
                    inputType: TextInputType.visiblePassword,
                    icon: Icons.password,
                    isPasswordField: true,
                    controller: newPasswordController,
                  ),
                  FormContainerWidget(
                    labelText: 'Confirm New Password',
                    hintText: 'Enter your new password again',
                    inputType: TextInputType.visiblePassword,
                    icon: Icons.password,
                    isPasswordField: true,
                    controller: confirmNewPasswordController,
                  ),
                  sizeVer(20),
                  FormButtonWidget(
                    text: 'Save',
                    backgroundColor: Colors.purpleAccent,
                    textColor: Colors.black,
                    onPressed: changePassword,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> changePassword() async {
    String oldPassword = oldPasswordController.text.trim();
    String newPassword = newPasswordController.text.trim();
    String confirmNewPassword = confirmNewPasswordController.text.trim();

    if (newPassword != confirmNewPassword) {
      UIHelper.toast(
          "New passwords do not match", Toast.LENGTH_LONG, ToastGravity.BOTTOM);
      return;
    }
    if (newPassword == oldPassword || confirmNewPassword == oldPassword) {
      UIHelper.toast(
          "New and Old Passwords cannot be same", Toast.LENGTH_LONG, ToastGravity.BOTTOM);
      return;
    }

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      UIHelper.toast("User not found", Toast.LENGTH_LONG, ToastGravity.BOTTOM);
      return;
    }

    AuthCredential credential = EmailAuthProvider.credential(
      email: user.email!,
      password: oldPassword,
    );

    UIHelper.showLoadingDialog(context, "Updating Password");
    try {
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
      UIHelper.toast("Password updated successfully", Toast.LENGTH_LONG,
          ToastGravity.BOTTOM);
    } on FirebaseAuthException catch (e) {
      UIHelper.toast(
          "Error: ${e.message}", Toast.LENGTH_LONG, ToastGravity.BOTTOM);
    } catch (e) {
      UIHelper.toast("An unexpected error occurred", Toast.LENGTH_LONG,
          ToastGravity.BOTTOM);
    }
    Navigator.pop(context);
  }
}
