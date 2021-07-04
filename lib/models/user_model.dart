// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.fullName,
        this.email,
        this.phoneNumber,
        this.accountNumber,
        this.ifsc,
    });

    String fullName;
    String email;
    String phoneNumber;
    String accountNumber;
    String ifsc;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        fullName: json["fullName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        accountNumber: json["accountNumber"],
        ifsc: json["ifsc"],
    );

    Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "email": email,
        "phoneNumber": phoneNumber,
        "accountNumber": accountNumber,
        "ifsc": ifsc,
    };
}