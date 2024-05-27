import 'package:chat_app/authentication/login_page.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/chat_room_model.dart';
import 'package:chat_app/helper/firebase_helper.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/profile_page.dart';
import 'package:chat_app/pages/search_page.dart';
import 'package:chat_app/helper/widgets/consts.dart';
import 'package:chat_app/helper/widgets/form_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                  sizeVer(20),
                  Center(
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage(widget.userModel.profilepic!),
                      backgroundColor: blueColor,
                      radius: 60,
                    ),
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
                    onPressed: () {},
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
              onPressed: () {},
              backgroundColor: const Color.fromARGB(100, 185, 185, 255),
              textColor: Colors.black,
            ),
            FormButtonWidget(
              text: "LogOut",
              backgroundColor: Colors.redAccent,
              textColor: Colors.white,
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
            ),
            Text("Made with ❤️ by Kartik.", textAlign: TextAlign.left,style: GoogleFonts.playfair(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: Colors.red,
            ),),
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
                                  return Container(
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
                                        chatRoomModel.lastMessage.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14),
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
                                              firebaseUser: widget.firebaseUser,
                                              chatUser: targetUser,
                                              chatroom: chatRoomModel,
                                            ),
                                          ),
                                        );
                                      },
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
