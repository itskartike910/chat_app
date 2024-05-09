class MessageModel {
  String? sender;
  String? message;
  bool? seen;
  DateTime? timeStamp;

  MessageModel({this.sender, this.message, this.seen, this.timeStamp});

  MessageModel.fromMap(Map<String, dynamic> map){
    sender = map["sender"];
    message = map["message"];
    seen = map["seen"];
    timeStamp = map["timeStamp"].toDate();
  }
  Map<String,dynamic> toMap(){
    return {
      "sender": sender,
      "message": message,
      "seen": seen,
      "timeStamp": timeStamp,
    };
  }
}
