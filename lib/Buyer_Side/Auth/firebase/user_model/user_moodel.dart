class userModel {
  String? id;
  String? email;
  String? userName;
  String? contact;
  String? address;

  userModel({
    this.id,
    required this.contact,
    required this.email,
    required this.userName,
    required this.address
  });

  toJson() {
    return{
      'User_Email': email,
      'User_Name' : userName,
      'User_Phone' : contact,
      'User_Address': address
    };
  }




}