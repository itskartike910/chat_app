class ChatRoomModel {
  String? charRoomId;
  List<String>? userList;

  ChatRoomModel({this.charRoomId, this.userList});

  ChatRoomModel.fromMap(Map<String, dynamic> map){
    charRoomId = map["chatRoomId"];
    userList = List<String>.from(map["userList"]);
  }

  Map<String, dynamic> toMap(){
    return {
      "chatRoomId": charRoomId,
      "userList": userList,
    };
  }
}
