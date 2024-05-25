import 'package:chat_app/models/chat_room_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/widgets/consts.dart';
import 'package:chat_app/widgets/form_button.dart';
import 'package:chat_app/widgets/form_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/main.dart';

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
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .where("email",
                              isEqualTo:
                                  searchController.text.trim().toString())
                          .where("email",
                              isNotEqualTo:
                                  widget.userModel.email!.trim().toString())
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
                                  ChatRoomModel? chatRoomModel =
                                      await getChatRoom(searchedUser);
                                  if (chatRoomModel != null) {
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                    Navigator.push(
                                      // ignore: use_build_context_synchronously
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
                              // toast("No Result Found!!", Toast.LENGTH_LONG);
                              return const Text("No Results Found!!");
                            }
                          } else if (snapshot.hasError) {
                            // toast("An error occured!!", Toast.LENGTH_LONG);
                            return const Text("An error occured!!");
                          } else {
                            // toast("No Result Found!!", Toast.LENGTH_LONG);
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
      //Fetching the existing one
      // toast("ChatRoom already exists", Toast.LENGTH_SHORT);
      var docData = snapshot.docs[0].data();
      ChatRoomModel existingChatroom =
          ChatRoomModel.fromMap(docData as Map<String, dynamic>);
      chatRoomModel = existingChatroom;
    } else {
      //Creating a new one
      // toast("ChatRoom not created", Toast.LENGTH_SHORT);
      ChatRoomModel newChatroom = ChatRoomModel(
        charRoomId: uuid.v1(),
        lastMessage: "",
        participants: {
          widget.userModel.uid.toString(): true,
          targetUser.uid.toString(): true,
        },
      );

      await FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(newChatroom.charRoomId)
          .set(newChatroom.toMap());
      // toast("New Chatroom created.", Toast.LENGTH_SHORT);
      chatRoomModel = newChatroom;
    }
    return chatRoomModel;
  }
}
