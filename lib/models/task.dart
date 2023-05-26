import 'dart:convert';

Task taskFromJson(String str) => Task.fromJson(json.decode(str));

String taskToJson(Task data) => json.encode(data.toJson());

class Task {
    
    String uidUser;
    String ?title;
    String ?description;
    bool ?status;
    String ?time;

    Task({
        required this.uidUser,
        required this.title,
        required this.description,
        required this.status,
        required this.time,
    });

    factory Task.fromJson(Map<String, dynamic> json) => Task(
        uidUser: json["uidUser"],
        title: json["title"],
        description: json["description"],
        status: json["status"],
        time: json["time"],
    );

    Map<String, dynamic> toJson() => {
        "uidUser": uidUser,
        "title": title,
        "description": description,
        "status": status,
        "time": time,
    };
}
