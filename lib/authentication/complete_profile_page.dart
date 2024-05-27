// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:chat_app/helper/ui_helper.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/helper/widgets/consts.dart';
import 'package:chat_app/helper/widgets/form_button.dart';
import 'package:chat_app/helper/widgets/form_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CompleteProfilePage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const CompleteProfilePage(
      {super.key, required this.userModel, required this.firebaseUser});

  @override
  State<CompleteProfilePage> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfilePage> {
  File? imageFile;
  TextEditingController fullName = TextEditingController();

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
          child: ListView(
            children: [
              sizeVer(10),
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
                onPressed: () {
                  showPhotoOptions();
                },
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: blueColor,
                  backgroundImage:
                      (imageFile != null) ? FileImage(imageFile!) : null,
                  child: (imageFile == null)
                      ? const Icon(
                          Icons.person,
                          size: 80,
                          color: Colors.white,
                        )
                      : null,
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
                controller: fullName,
              ),
              // Text("Email: ${widget.firebaseUser.email}",textAlign: TextAlign.center,),
              FormContainerWidget(
                // labelText: 'Email',
                enabled: false,
                hintText: "Email: ${widget.firebaseUser.email}",
                inputType: TextInputType.emailAddress,
                icon: Icons.email,
              ),
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
                text: 'Continue',
                backgroundColor: Colors.purpleAccent,
                textColor: Colors.black,
                onPressed: () {
                  checkValues();
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
                          builder: (context) => HomePage(
                                userModel: widget.userModel,
                                firebaseUser: widget.firebaseUser,
                              ))).then((result) {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showPhotoOptions() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Choose Profile Picture",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: bgColor,
          elevation: 5,
          shadowColor: const Color.fromARGB(255, 36, 255, 215),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text(
                  "Take a Photo",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Navigator.pop(context);
                  selectImages(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_album),
                title: const Text(
                  "Upload from Gallery",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Navigator.pop(context);
                  selectImages(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void selectImages(
    ImageSource img,
  ) async {
    XFile? pickedfile = await ImagePicker().pickImage(source: img);
    if (pickedfile != null) {
      cropImage(pickedfile);
    }
  }

  void cropImage(XFile file) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 50,
    );

    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
  }

  void checkValues() {
    String fname = fullName.text.trim();
    if (fname == "") {
      UIHelper.toast(
          "Please enter your name!!", Toast.LENGTH_SHORT, ToastGravity.BOTTOM);
    } else if (imageFile == null) {
      UIHelper.toast("Please insert your image!!", Toast.LENGTH_SHORT,
          ToastGravity.BOTTOM);
    } else {
      uploadData();
    }
  }

  void uploadData() async {
    UIHelper.showLoadingDialog(context, "Uploading Data...");
    try {
      UploadTask uploadTask = FirebaseStorage.instance
          .ref("profilepictures")
          .child(widget.userModel.uid.toString())
          .putFile(imageFile!);

      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();
      String fname = fullName.text.trim();

      widget.userModel.profilepic = imageUrl;
      widget.userModel.name = fname;

      await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.userModel.uid)
          .set(widget.userModel.toMap())
          .then((value) {
        UIHelper.toast(
            "Data Uploaded...", Toast.LENGTH_LONG, ToastGravity.BOTTOM);
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              userModel: widget.userModel,
              firebaseUser: widget.firebaseUser,
            ),
          ),
        );
      });
    } catch (e) {
      Navigator.pop(context);
      UIHelper.toast(
          "Error uploading data: $e", Toast.LENGTH_LONG, ToastGravity.BOTTOM);
    }
  }
}
