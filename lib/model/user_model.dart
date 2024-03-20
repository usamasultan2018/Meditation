class UserModel {
  String? uid;
  String? username;
  String? email;
  String? profileUrl;

  UserModel({this.uid, this.username, this.email, this.profileUrl});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'profileUrl': profileUrl,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      username: json['username'],
      email: json['email'],
      profileUrl: json['profileUrl'],
    );
  }
}
