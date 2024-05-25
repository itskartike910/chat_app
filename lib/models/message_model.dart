class MessageModel {
  String? messageId;
  String? sender;
  String? message;
  bool? seen;
  DateTime? timeStamp;

  MessageModel(
      {this.messageId, this.sender, this.message, this.seen, this.timeStamp});

  MessageModel.fromMap(Map<String, dynamic> map) {
    messageId = map["messageId"];
    sender = map["sender"];
    message = map["message"];
    seen = map["seen"];
    timeStamp = map["timeStamp"].toDate();
  }
  Map<String, dynamic> toMap() {
    return {
      "messageId": messageId,
      "sender": sender,
      "message": message,
      "seen": seen,
      "timeStamp": timeStamp,
    };
  }
}
