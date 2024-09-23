class MessageModel {
  String? messageId;
  String? sender;
  String? message;
  bool? seen;
  DateTime? timeStamp;
  bool? containsImage;

  MessageModel({
    this.messageId,
    this.sender,
    this.message,
    this.seen,
    this.timeStamp,
    this.containsImage,
  });

  MessageModel.fromMap(Map<String, dynamic> map) {
    messageId = map["messageId"];
    sender = map["sender"];
    message = map["message"];
    seen = map["seen"];
    timeStamp = map["timeStamp"].toDate();
    containsImage = map["containsImage"];
  }
  Map<String, dynamic> toMap() {
    return {
      "messageId": messageId,
      "sender": sender,
      "message": message,
      "seen": seen,
      "timeStamp": timeStamp,
      "containsImage": containsImage,
    };
  }
}
