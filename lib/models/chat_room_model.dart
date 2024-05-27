class ChatRoomModel {
  String? chatRoomId;
  Map<String, dynamic>? participants;
  String? lastMessage;
  DateTime? lastMessageTime;
  List<dynamic>? users;

  ChatRoomModel({
    this.chatRoomId,
    this.participants,
    this.lastMessage,
    this.lastMessageTime,
    this.users,
  });

  ChatRoomModel.fromMap(Map<String, dynamic> map) {
    chatRoomId = map["chatRoomId"];
    participants = map["participants"];
    lastMessage = map["lastMessage"];
    lastMessageTime = map["lastMessageTime"].toDate();
    users = map["users"];
  }

  Map<String, dynamic> toMap() {
    return {
      "chatRoomId": chatRoomId,
      "participants": participants,
      "lastMessage": lastMessage,
      "lastMessageTime": lastMessageTime,
      "users": users,
    };
  }
}
