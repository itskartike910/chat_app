class UserModel {
  String? uid;
  String? name;
  String? email;
  String? profilepic;

  UserModel({this.uid, this.name, this.email, this.profilepic});

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    name = map["name"];
    email = map["email"];
    profilepic = map["profilepic"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "profilepic": profilepic,
    };
  }
}
