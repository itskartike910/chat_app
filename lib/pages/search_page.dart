import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/widgets/consts.dart';
import 'package:chat_app/widgets/form_button.dart';
import 'package:chat_app/widgets/form_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchPage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const SearchPage(
      {super.key, required this.userModel, required this.firebaseUser});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
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
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Search for a User',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FormContainerWidget(
                      labelText: 'Search',
                      hintText: 'Email Address',
                      inputType: TextInputType.text,
                      controller: searchController,
                    ),
                    sizeVer(15),
                    FormButtonWidget(
                      text: 'Start Searching',
                      backgroundColor: Colors.purpleAccent,
                      textColor: Colors.black,
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                    sizeVer(10),
                    // const Text(
                    //   'Search Results',
                    //   style: TextStyle(
                    //     fontSize: 20,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // sizeVer(10),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .where("email",
                                isEqualTo:
                                    searchController.text.trim().toString())
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            if (snapshot.hasData) {
                              QuerySnapshot querySnapshot =
                                  snapshot.data as QuerySnapshot;

                              if (querySnapshot.docs.isNotEmpty) {
                                Map<String, dynamic> userMap =
                                    querySnapshot.docs[0].data()
                                        as Map<String, dynamic>;

                                UserModel searchedUser =
                                    UserModel.fromMap(userMap);

                                return ListTile(
                                  title: Text(
                                    searchedUser.name.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18),
                                  ),
                                  subtitle: Text(
                                    searchedUser.email.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  titleAlignment: ListTileTitleAlignment.center,
                              
                                );
                              } else {
                                toast("No Result Found!!", Toast.LENGTH_LONG);
                                return const Text("No Results Found!!");
                              }
                            } else if (snapshot.hasError) {
                              toast("An error occured!!", Toast.LENGTH_LONG);
                              return const Text("An error occured!!");
                            } else {
                              toast("No Result Found!!", Toast.LENGTH_LONG);
                              return const Text("No Results Found!!");
                            }
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
