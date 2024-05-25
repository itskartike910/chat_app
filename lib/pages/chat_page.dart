import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/widgets/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  final UserModel chatUser;
  const ChatPage(
      {super.key,
      required this.userModel,
      required this.firebaseUser,
      required this.chatUser});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage(widget.chatUser.profilepic!),
            ),
            sizeHor(20),
            Text(
              widget.chatUser.name!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: bgColor,
        shadowColor: const Color.fromARGB(255, 36, 255, 215),
        elevation: 5,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Container(
          // padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: gradientBackground,
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                    // color: Colors.black54,
                    ),
              ),
              Container(
                color: Colors.black12,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Type a message',
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.send,
                          color: Colors.green,
                          size: 25,
                          fill: BorderSide.strokeAlignCenter,
                        ),
                      ),
                      // CupertinoButton(
                      //   borderRadius:
                      //       const BorderRadius.all(Radius.circular(20.0)),
                      //   onPressed: () {},
                      //   child: const Icon(
                      //     Icons.send,
                      //     color: Colors.green,
                      //     size: 25,
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // endDrawer: Drawer(),
    );
  }
}
