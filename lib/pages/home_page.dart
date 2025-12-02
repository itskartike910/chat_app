import 'package:chat_app/authentication/change_password.dart';
import 'package:chat_app/authentication/login_page.dart';
import 'package:chat_app/helper/ui_helper.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/chat_room_model.dart';
import 'package:chat_app/helper/firebase_helper.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/profile_page.dart';
import 'package:chat_app/pages/search_page.dart';
import 'package:chat_app/pages/ai_chat_page.dart';
import 'package:chat_app/helper/widgets/consts.dart';
import 'package:chat_app/helper/widgets/form_button.dart';
import 'package:chat_app/pages/settings_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  void initState() {
    super.initState();
    setupFirebaseMessaging();
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
        actions: [
          PopupMenuButton<String>(
            color: bgColor,
            elevation: 5,
            shadowColor: const Color.fromARGB(255, 36, 255, 215),
            iconSize: 25,
            onSelected: (value) {
              // Handle the selected menu option
              switch (value) {
                case 'About App':
                  // Navigate to info page or show dialog
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          "About ChatBox ",
                          style: GoogleFonts.dancingScript(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        content: const Text(
                            "ChatBox is a real time chatting  application made using Flutter and Firebase.\nFor chatting with a person first you both have to create account, then search for the user by email or name then start chatting.\n\nThis app is made by Mr. Kartik Kumar."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Close"),
                          ),
                        ],
                      );
                    },
                  );
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return {
                'About App',
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      drawer: Drawer(
        elevation: 5,
        shadowColor: const Color.fromARGB(255, 36, 255, 215),
        backgroundColor: bgColor,
        surfaceTintColor: primaryColor,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  sizeVer(10),
                  Center(
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage(widget.userModel.profilepic!),
                      backgroundColor: blueColor,
                      radius: 60,
                    ),
                  ),
                  // sizeVer(20),
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
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.red,
                      letterSpacing: 1.5,
                      wordSpacing: 2,
                    ),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                  sizeVer(10),
                  const Text(
                    "________________________________________________________________________________________________________________________",
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: true,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      backgroundColor: Colors.cyan,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  FormButtonWidget(
                    text: "Account",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(
                            user: widget.userModel,
                            currentUser: true,
                          ),
                        ),
                      );
                    },
                    backgroundColor: const Color.fromARGB(100, 185, 185, 255),
                    textColor: Colors.black,
                  ),
                  FormButtonWidget(
                    text: "Settings",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsPage(),
                        ),
                      );
                    },
                    backgroundColor: const Color.fromARGB(100, 185, 185, 255),
                    textColor: Colors.black,
                  ),
                  FormButtonWidget(
                    text: "AI Chat",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AIChatPage(),
                        ),
                      );
                    },
                    backgroundColor: const Color.fromARGB(100, 185, 185, 255),
                    textColor: Colors.black,
                  ),
                ],
              ),
            ),
            const Text(
              "________________________________________________________________________________________________________________________",
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: true,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                backgroundColor: Colors.cyan,
              ),
              textAlign: TextAlign.justify,
            ),
            FormButtonWidget(
              text: "Change Password",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangePass(user: widget.userModel),
                  ),
                );
              },
              backgroundColor: const Color.fromARGB(100, 185, 185, 255),
              textColor: Colors.black,
            ),
            FormButtonWidget(
              text: "LogOut",
              backgroundColor: Colors.redAccent,
              textColor: Colors.white,
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Log Out"),
                      content: const Text("Are you sure you want to log out?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("No"),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            UIHelper.showLoadingDialog(
                                context, "Logging Out...");
                            await FirebaseAuth.instance.signOut();
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                            UIHelper.toast("Successfully Logged Out.",
                                Toast.LENGTH_SHORT, ToastGravity.BOTTOM);
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            Text(
              "Made with ❤️ by Kartik.",
              textAlign: TextAlign.left,
              style: GoogleFonts.playfair(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "ai_chat",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AIChatPage(),
                ),
              );
            },
            elevation: 5,
            backgroundColor: const Color.fromARGB(255, 251, 194, 255),
            splashColor: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.smart_toy,
                  size: 28,
                  shadows: [Shadow(color: Colors.black)],
                ),
                Text(
                  "AI Chat",
                  style: GoogleFonts.dancingScript(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "search_user",
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.search_sharp,
                  size: 28,
                  shadows: [Shadow(color: Colors.black)],
                ),
                Text(
                  "Search User",
                  style: GoogleFonts.dancingScript(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: gradientBackground,
          ),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("chatrooms")
                .where("users", arrayContains: widget.userModel.uid)
                .orderBy("lastMessageTime", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  QuerySnapshot chatroomSnapshot =
                      snapshot.data as QuerySnapshot;

                  return ListView.builder(
                      itemCount: chatroomSnapshot.docs.length,
                      itemBuilder: (context, index) {
                        ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(
                            chatroomSnapshot.docs[index].data()
                                as Map<String, dynamic>);
                        Map<String, dynamic> participants =
                            chatRoomModel.participants!;
                        List<String> participantsKeys =
                            participants.keys.toList();
                        participantsKeys.remove(widget.userModel.uid);
                        return FutureBuilder(
                            future: FireBaseHelper.getUserModelById(
                                participantsKeys[0]),
                            builder: (context, userData) {
                              if (userData.connectionState ==
                                  ConnectionState.done) {
                                if (userData.data != null) {
                                  UserModel targetUser =
                                      userData.data as UserModel;
                                  return InkWell(
                                    onLongPress: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text("Delete Chat"),
                                            content: const Text(
                                                "Are you sure you want to delete this chat?"),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("No"),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  UIHelper.showLoadingDialog(
                                                      context,
                                                      "Deleting Chat...");
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection("chatrooms")
                                                      .doc(chatRoomModel
                                                          .chatRoomId)
                                                      .delete();
                                                  Navigator.popUntil(context,
                                                      (route) => route.isFirst);
                                                  UIHelper.toast(
                                                      "Chat Deleted",
                                                      Toast.LENGTH_SHORT,
                                                      ToastGravity.BOTTOM);
                                                },
                                                child: const Text("Yes"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.orangeAccent,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                        title: Text(
                                          targetUser.name.toString(),
                                          style: GoogleFonts.ubuntu(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 18),
                                        ),
                                        subtitle: Text(
                                          chatRoomModel.lastMessage
                                                      .toString() !=
                                                  ""
                                              ? chatRoomModel.lastMessage
                                                  .toString()
                                              : "Say Hii to your new friend!!",
                                          maxLines: 1,
                                          softWrap: true,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ),
                                        ),
                                        titleAlignment:
                                            ListTileTitleAlignment.center,
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              targetUser.profilepic!),
                                          radius: 22,
                                        ),
                                        onTap: () async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ChatPage(
                                                userModel: widget.userModel,
                                                firebaseUser:
                                                    widget.firebaseUser,
                                                chatUser: targetUser,
                                                chatroom: chatRoomModel,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              } else {
                                return Container();
                              }
                            });
                      });
                } else if (snapshot.hasError) {
                  return const Center(
                    // child: Text(snapshot.error.toString()),
                    child: Text("Error Fetching the Data."),
                  );
                } else {
                  return const Center(
                    child: Text("No Chats Yet."),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
