import 'package:meta/meta.dart';



class UserModel {
  final int numberId;
  final String email;
  final String first_name;
  final String last_name;
  final String avatar;


  UserModel({@required this.numberId,
   @required this.email,
    @required this.first_name, 
    @required this.last_name, 
    @required this.avatar});



 factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      avatar: json['avatar']);
  }

  
   Map<String, dynamic> toJson() {
    return {
      'email': email,
      'first_name': first_name,
      'last_name': last_name,
      'avatar': avatar
    };
  }

}

