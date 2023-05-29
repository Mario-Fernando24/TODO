import 'dart:convert';

Task taskFromJson(String str) => Task.fromJson(json.decode(str));

String taskToJson(Task data) => json.encode(data.toJson());

class Task {
    String ?uid;
    String ?uidUser;
    String ?title;
    String ?description;
    bool ?status;
    String ?time;


    Task({
         this.uid,
        required this.uidUser,
        required this.title,
        required this.description,
        required this.status,
        required this.time,
    });

    factory Task.fromJson(Map<String, dynamic> json) => Task(
        uid: json["uid"],
        uidUser: json["uidUser"],
        title: json["title"],
        description: json["description"],
        status: json["status"],
        time: json["time"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "uidUser": uidUser,
        "title": title,
        "description": description,
        "status": status,
        "time": time,
    };
}
