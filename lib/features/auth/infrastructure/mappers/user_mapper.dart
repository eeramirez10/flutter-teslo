import 'package:teslo_shop/features/auth/domain/index.dart';

class UserMapper {
  static User userJsonToEntity(Map<String, dynamic> json) {
    return User(
        id: json["id"],
        email: json["email"],
        isActive: json["isActive"],
        fullName: json["fullName"],
        roles: List<String>.from(json["roles"].map((role) => role)),
        token: json["token"]);
  }
}
