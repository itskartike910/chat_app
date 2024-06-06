import 'package:chat_app/main.dart';
import 'package:chat_app/models/chat_room_model.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/helper/ui_helper.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/helper/widgets/consts.dart';
import 'package:chat_app/pages/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // UIHelper.toast(
    //     "ScreenWidth: $screenWidth", Toast.LENGTH_LONG, ToastGravity.BOTTOM);
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          splashColor: Colors.lightBlue,
          radius: 40,
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            Future.delayed(
                const Duration(
                  milliseconds: 100,
                ), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(
                    user: widget.chatUser,
                    currentUser: false,
                  ),
                ),
              );
            });
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
                case 'Search':
                  // Navigate to info page or show dialog
                  // AlertDialog alertDialog = AlertDialog();
                  UIHelper.toast("Currently Implementing...",
                      Toast.LENGTH_SHORT, ToastGravity.BOTTOM);
                  break;
                case 'Clear Chat':
                  // Clear chat logic
                  break;
                case 'Report & Block':
                  // Block user logic
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Search', 'Clear Chat', 'Report & Block'}
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
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: gradientBackground,
          ),
          child: Column(
            children: [
              Text(
                DateFormat('MMMM dd, yyyy')
                    .format(widget.chatroom.lastMessageTime!),
                style: GoogleFonts.play(
                  color: txtColor,
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
                                String formattedTime =
                                    DateFormat('h:mm a - dd MMM')
                                        .format(currentMessage.timeStamp!);
                                currMsgSeen(currentMessage);
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
                                                UIHelper.showLoadingDialog(
                                                    context,
                                                    "Deleting Message");
                                                FirebaseFirestore.instance
                                                    .collection("chatrooms")
                                                    .doc(widget
                                                        .chatroom.chatRoomId)
                                                    .collection("messages")
                                                    .doc(currentMessage
                                                        .messageId)
                                                    .delete();
                                                Navigator.pop(context);
                                                UIHelper.toast(
                                                    "Message Deleted",
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
                                  child: Row(
                                    mainAxisAlignment: currentMessage.sender ==
                                            widget.firebaseUser.uid
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 10,
                                          ),
                                          constraints: BoxConstraints(
                                            maxHeight: double.infinity,
                                            maxWidth: (screenWidth * 4 / 5),
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
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
                                                currentMessage.message
                                                    .toString(),
                                                maxLines: null,
                                                softWrap: true,
                                                overflow: TextOverflow.clip,
                                                style: GoogleFonts.ubuntu(
                                                    color: Colors.black,
                                                    fontSize: messageFontSize,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                formattedTime,
                                                maxLines: null,
                                                softWrap: true,
                                                overflow: TextOverflow.clip,
                                                style: GoogleFonts.quicksand(
                                                    color: Colors.white70,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            2, 0, 0, 0),
                                        child: currentMessage.seen!
                                            ? (currentMessage.sender ==
                                                    widget.firebaseUser.uid)
                                                ? const Icon(
                                                    Icons.check_circle,
                                                    color: Colors.green,
                                                    size: 20,
                                                  )
                                                : const Text("")
                                            : (currentMessage.sender ==
                                                    widget.firebaseUser.uid)
                                                ? const Icon(
                                                    Icons.check_circle,
                                                    color: Colors.grey,
                                                    size: 20,
                                                  )
                                                : const Text(""),
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
                color: Colors.black12,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  child: Row(
                    children: [
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: const Icon(
                      //     Icons.attach_file,
                      //     color: Colors.green,
                      //     size: 30,
                      //     fill: BorderSide.strokeAlignCenter,
                      //     applyTextScaling: true,
                      //   ),
                      // ),
                      Flexible(
                        child: SingleChildScrollView(
                          reverse: true,
                          child: TextField(
                            controller: message,
                            enableInteractiveSelection: true,
                            scrollPhysics: const BouncingScrollPhysics(),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            maxLength: null,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              hintText: 'Type a message',
                              hintStyle: GoogleFonts.ubuntu(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: messageFontSize,
                              ),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            style: GoogleFonts.ubuntu(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: messageFontSize,
                            ),
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
      widget.chatroom.lastMessageSender = widget.firebaseUser.uid;
      FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(widget.chatroom.chatRoomId)
          .set(widget.chatroom.toMap());

      UIHelper.toast("Message sent", Toast.LENGTH_SHORT, ToastGravity.CENTER);
    }
  }

  void currMsgSeen(MessageModel messageModel) {
    if (widget.chatroom.lastMessageSender == widget.chatUser.uid) {
      messageModel.seen = true;
      MessageModel newMsg = MessageModel(
        messageId: messageModel.messageId,
        message: messageModel.message,
        sender: messageModel.sender,
        timeStamp: messageModel.timeStamp,
        seen: true,
      );
      FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(widget.chatroom.chatRoomId)
          .collection("messages")
          .doc(messageModel.messageId)
          .set(newMsg.toMap());
    }
  }
}
