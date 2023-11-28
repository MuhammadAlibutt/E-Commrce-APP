//user model
class UserModel {
  String? username;
  String? email;
  String? phone;
  String? uId;
  String? image;
  String? userType;
  List<String>? following;
  List<String>? followers;

  UserModel({
    this.username,
    this.email,
    this.phone,
    this.uId,
    this.image,
    this.userType,
    this.following,
    this.followers,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    username = json!['UserName'];
    email = json['UserEmail'];
    phone = json['UserPhone'];
    uId = json['UserUID'];
    image = json['image'];
    userType = json['userType'];
    following = json['following'].cast<String>();
    followers = json['followers'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    return {
      'UserName': username,
      'UserEmail': email,
      'UserPhone': phone,
      'UserUID': uId,
      'image': image,
      'userType': userType,
      'following': following,
      'followers': followers,
    };
  }
}
