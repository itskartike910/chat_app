class ChatRoomModel {
  String? charRoomId;
  Map<String, dynamic>? participants;
  String? lastMessage;

  ChatRoomModel({this.charRoomId, this.participants, this.lastMessage});

  ChatRoomModel.fromMap(Map<String, dynamic> map){
    charRoomId = map["chatRoomId"];
    participants = map["participants"];
    lastMessage = map["lastMessage"];
  }

  Map<String, dynamic> toMap(){
    return {
      "chatRoomId": charRoomId,
      "participants": participants,
      "lastMessage": lastMessage,
    };
  }
}
