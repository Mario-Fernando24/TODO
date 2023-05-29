// To parse this JSON data, do
//
//     final userM = userMFromJson(jsonString);

import 'dart:convert';

UserM userMFromJson(String str) => UserM.fromJson(json.decode(str));

String userMToJson(UserM data) => json.encode(data.toJson());

class UserM {
    String ? email;
    String ?name;
    String ?uid;

    UserM({
         this.email,
         this.name,
         this.uid,
    });

    factory UserM.fromJson(Map<String, dynamic> json) => UserM(
        email: json["email"],
        name: json["name"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "uid": uid,
    };
}
