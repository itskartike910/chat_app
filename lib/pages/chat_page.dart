import 'package:chat_app/main.dart';
import 'package:chat_app/models/chat_room_model.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/helper/ui_helper.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/helper/widgets/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  final UserModel chatUser;
  final ChatRoomModel chatroom;
  const ChatPage({
    super.key,
    required this.userModel,
    required this.firebaseUser,
    required this.chatUser,
    required this.chatroom,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController message = TextEditingController();
  String msgDate = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          splashColor: Colors.lightBlue,
          radius: 40,
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => ProfilePage(
            //       userModel: widget.chatUser,
            //       firebaseUser: widget.firebaseUser,
            //     ),
            //   ),
            // );
          },
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(widget.chatUser.profilepic!),
              ),
              sizeHor(20),
              Text(
                widget.chatUser.name!,
                style: GoogleFonts.ubuntu(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: bgColor,
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
                case 'Info':
                  // Navigate to info page or show dialog
                  break;
                case 'Clear Chat':
                  // Clear chat logic
                  // FirebaseFirestore.instance
                  //     .collection("chatrooms")
                  //     .doc(widget.chatroom.charRoomId)
                  //     .collection("messaages")
                  //     .doc()
                  //     .delete();
                  break;
                case 'Report & Block':
                  // Block user logic
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Info', 'Clear Chat', 'Report & Block'}
                  .map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      // endDrawer: Drawer(),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: gradientBackground,
          ),
          child: Column(
            children: [
              Text(
                msgDate,
                style: GoogleFonts.play(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("chatrooms")
                          .doc(widget.chatroom.chatRoomId)
                          .collection("messages")
                          .orderBy("timeStamp", descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          if (snapshot.hasData) {
                            QuerySnapshot dataSnapshot =
                                snapshot.data as QuerySnapshot;
                            return ListView.builder(
                              reverse: true,
                              itemCount: dataSnapshot.docs.length,
                              itemBuilder: ((context, index) {
                                MessageModel currentMessage =
                                    MessageModel.fromMap(
                                        dataSnapshot.docs[index].data()
                                            as Map<String, dynamic>);
                                String formattedTime = DateFormat('h:mm a')
                                    .format(currentMessage.timeStamp!);
                                String formattedDate =
                                    DateFormat('MMMM d, yyyy')
                                        .format(currentMessage.timeStamp!);
                                // setState(() {
                                msgDate = formattedDate;
                                // });
                                return InkWell(
                                  onLongPress: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: bgColor,
                                          title: const Text("Delete Message"),
                                          content: const Text(
                                              "Are you sure you want to delete this message?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("No"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                FirebaseFirestore.instance
                                                    .collection("chatrooms")
                                                    .doc(widget
                                                        .chatroom.chatRoomId)
                                                    .collection("messages")
                                                    .doc(currentMessage
                                                        .messageId)
                                                    .delete();
                                              },
                                              child: const Text("Yes"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: currentMessage.sender ==
                                            widget.firebaseUser.uid
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 10,
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: currentMessage.sender ==
                                                  widget.firebaseUser.uid
                                              ? Colors.green
                                              : Colors.blue,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              currentMessage.sender ==
                                                      widget.firebaseUser.uid
                                                  ? CrossAxisAlignment.end
                                                  : CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              currentMessage.message.toString(),
                                              maxLines: null,
                                              style: GoogleFonts.ubuntu(
                                                  color: Colors.black,
                                                  fontSize: messageFontSize,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              formattedTime,
                                              style: GoogleFonts.quicksand(
                                                color: Colors.white70,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            );
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text(
                                  "Error in fetching data!, Please Check your internet connection"),
                            );
                          } else {
                            return const Center(
                              child: Text("Say Hii to your new friend"),
                            );
                          }
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
              ),
              Container(
                // height: 70,
                color: Colors.black12,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextField(
                          controller: message,
                          maxLines: null,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration(
                            hintText: 'Type a message',
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            // border: InputBorder.none
                          ),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          sendMessage();
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.green,
                          size: 30,
                          fill: BorderSide.strokeAlignCenter,
                          applyTextScaling: true,
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

  void sendMessage() async {
    String msg = message.text.trim();
    message.clear();
    if (msg != "") {
      MessageModel newMessage = MessageModel(
          messageId: uuid.v1(),
          message: msg,
          sender: widget.firebaseUser.uid,
          timeStamp: DateTime.now(),
          seen: false);

      FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(widget.chatroom.chatRoomId)
          .collection("messages")
          .doc(newMessage.messageId)
          .set(newMessage.toMap());

      widget.chatroom.lastMessage = msg;
      widget.chatroom.lastMessageTime = newMessage.timeStamp;
      FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(widget.chatroom.chatRoomId)
          .set(widget.chatroom.toMap());

      UIHelper.toast("Message sent", Toast.LENGTH_SHORT, ToastGravity.TOP);
    }
  }
}
