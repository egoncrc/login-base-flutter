
import 'package:teslo_shop/features/auth/domain/domain.dart';


class UserMapper {


  static User userJsonToEntity( Map<String,dynamic> json , String token) => User(
    id: json['id'],
    email: json['email'],
    fullName: json['first_name'] + ' ' + json['last_name'],
    rol: json['role'],
    token: token,
    // token: json['token'],
  );

}

