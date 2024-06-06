import 'package:chat_app/helper/ui_helper.dart';
import 'package:chat_app/models/chat_room_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/helper/widgets/consts.dart';
import 'package:chat_app/helper/widgets/form_button.dart';
import 'package:chat_app/helper/widgets/form_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const SearchPage(
      {super.key, required this.userModel, required this.firebaseUser});

  @override
  // ignore: library_private_types_in_public_api
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  String txt = "";

  bool isEmail(String input) {
    return RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
        .hasMatch(input);
  }

  Stream<QuerySnapshot> buildQuery() {
    String searchText = searchController.text.trim();
    if (isEmail(searchText)) {
      return FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: searchText)
          .where("email",
              isNotEqualTo: widget.userModel.email!.trim().toString())
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection("users")
          .where("name", isEqualTo: searchText)
          .snapshots();
    }
  }

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
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Search for a User',
                      style: GoogleFonts.playfair(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    sizeVer(5),
                    Text(
                      "Search for a user by his/her Email or exact Name..",
                      style: GoogleFonts.playfair(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    sizeVer(10),
                    FormContainerWidget(
                      labelText: 'Search',
                      hintText: 'Email Address or Name',
                      inputType: TextInputType.text,
                      controller: searchController,
                    ),
                    sizeVer(15),
                    FormButtonWidget(
                      text: 'Start Searching',
                      backgroundColor: Colors.purpleAccent,
                      textColor: Colors.black,
                      onPressed: () {
                        setState(() {
                          txt = "Search Results";
                        });
                      },
                    ),
                    sizeVer(10),
                    Text(
                      txt,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    sizeVer(10),
                    StreamBuilder(
                      stream: buildQuery(),
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
                                      fontSize: 14),
                                ),
                                titleAlignment: ListTileTitleAlignment.center,
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(searchedUser.profilepic!),
                                  radius: 22,
                                ),
                                trailing: const Icon(
                                  Icons.keyboard_arrow_right_sharp,
                                  size: 25,
                                ),
                                onTap: () async {
                                  UIHelper.showLoadingDialog(
                                      context, "Getting into the ChatRoom...");
                                  ChatRoomModel? chatRoomModel =
                                      await getChatRoom(searchedUser);
                                  if (chatRoomModel != null) {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatPage(
                                          userModel: widget.userModel,
                                          firebaseUser: widget.firebaseUser,
                                          chatUser: searchedUser,
                                          chatroom: chatRoomModel,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              );
                            } else {
                              return const Text("No Results Found!!");
                            }
                          } else if (snapshot.hasError) {
                            return const Text("An error occured!!");
                          } else {
                            return const Text("No Results Found!!");
                          }
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<ChatRoomModel?> getChatRoom(UserModel targetUser) async {
    ChatRoomModel? chatRoomModel;
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .where("participants.${widget.userModel.uid}", isEqualTo: true)
        .where("participants.${targetUser.uid}", isEqualTo: true)
        .get();

    if (snapshot.docs.isNotEmpty) {
      var docData = snapshot.docs[0].data();
      ChatRoomModel existingChatroom =
          ChatRoomModel.fromMap(docData as Map<String, dynamic>);
      chatRoomModel = existingChatroom;
    } else {
      UIHelper.showLoadingDialog(context, "Creating Chat Room...");
      ChatRoomModel newChatroom = ChatRoomModel(
        chatRoomId: uuid.v1(),
        lastMessage: "",
        participants: {
          widget.userModel.uid.toString(): true,
          targetUser.uid.toString(): true,
        },
        users: [widget.userModel.uid.toString(), targetUser.uid.toString()],
        lastMessageTime: DateTime.now(),
      );

      await FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(newChatroom.chatRoomId)
          .set(newChatroom.toMap());
      Navigator.pop(context);
      UIHelper.toast(
          "New Chatroom created.", Toast.LENGTH_SHORT, ToastGravity.BOTTOM);
      chatRoomModel = newChatroom;
    }
    return chatRoomModel;
  }
}
