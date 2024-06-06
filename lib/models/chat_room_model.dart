class ChatRoomModel {
  String? chatRoomId;
  Map<String, dynamic>? participants;
  String? lastMessage;
  String? lastMessageSender;
  DateTime? lastMessageTime;
  List<dynamic>? users;

  ChatRoomModel({
    this.chatRoomId,
    this.participants,
    this.lastMessage,
    this.lastMessageSender,
    this.lastMessageTime,
    this.users,
  });

  ChatRoomModel.fromMap(Map<String, dynamic> map) {
    chatRoomId = map["chatRoomId"];
    participants = map["participants"];
    lastMessage = map["lastMessage"];
    lastMessageSender = map["lastMessageSender"];
    lastMessageTime = map["lastMessageTime"].toDate();
    users = map["users"];
  }

  Map<String, dynamic> toMap() {
    return {
      "chatRoomId": chatRoomId,
      "participants": participants,
      "lastMessage": lastMessage,
      "lastMessageSender": lastMessageSender,
      "lastMessageTime": lastMessageTime,
      "users": users,
    };
  }
}
